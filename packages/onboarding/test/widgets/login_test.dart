import 'package:core/l10n/core_localizations.dart';
import 'package:core/widgets/button.dart';
import 'package:core/widgets/rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onboarding/view_models/login_view_model.dart';
import 'package:onboarding/widgets/login.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

Widget materialApp(Widget child) {
  return MaterialApp(
    home: Localizations(
      delegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      locale: const Locale('nl'),
      child: Tokens(
        tokens: DefaultTokens(),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('Login component show content', (WidgetTester tester) async {
    var formKey = GlobalKey<FormState>();

    // Act
    await tester.pumpWidget(materialApp(
      Login(
        viewModel: const LoginViewModel(),
        formKey: formKey,
        onShowLoginInformationClicked: (context) {},
        loginCodeController: TextEditingController(),
        birthDateController: TextEditingController(),
        onSubmitLogin: () {},
      ),
    ));

    expect(find.text('Vul de code in'), findsOneWidget);
    expect(find.byType(TextFormField), findsExactly(7));
    expect(find.byType(Button), findsOneWidget);
  });

  testWidgets('Login validate form on submit', (WidgetTester tester) async {
    var formKey = GlobalKey<FormState>();
    TextEditingController loginCodeController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();

    // Act
    await tester.pumpWidget(materialApp(
      Login(
        viewModel: const LoginViewModel(),
        formKey: formKey,
        onShowLoginInformationClicked: (context) {},
        loginCodeController: loginCodeController,
        birthDateController: birthDateController,
        onSubmitLogin: () {},
      ),
    ));

    await tester.enterText(find.byType(TextFormField).at(0), 'Z');
    await tester.enterText(find.byType(TextFormField).at(1), 'B');
    await tester.enterText(find.byType(TextFormField).at(2), 'J');
    await tester.enterText(find.byType(TextFormField).at(3), 'F');
    await tester.enterText(find.byType(TextFormField).at(4), 'T');
    await tester.enterText(find.byType(TextFormField).at(5), 'W');

    await tester.enterText(find.byType(TextFormField).at(6), '01-01-2000');

    var formState = tester.state<FormState>(find.byType(Form));
    formState.validate();
    await tester.pump();

    expect(loginCodeController.text.trim(), 'ZBJFTW');
    expect(birthDateController.text.trim(), '01-01-2000');
    expect(
        find.text(
            'Sorry, we herkennen deze code niet. Controleer of je het goed hebt ingevuld.'),
        findsNothing);
    expect(find.text('Vul alsjeblieft de code in.'), findsNothing);
    expect(find.text('Vul alsjeblieft je geboortedatum in.'), findsNothing);
  });

  testWidgets('Login validate form incomplete', (WidgetTester tester) async {
    var formKey = GlobalKey<FormState>();
    TextEditingController loginCodeController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();

    // Act
    await tester.pumpWidget(materialApp(
      Login(
        viewModel: const LoginViewModel(),
        formKey: formKey,
        onShowLoginInformationClicked: (context) {},
        loginCodeController: loginCodeController,
        birthDateController: birthDateController,
        onSubmitLogin: () {},
      ),
    ));

    await tester.enterText(find.byType(TextFormField).at(0), 'Z');

    var formState = tester.state<FormState>(find.byType(Form));
    formState.validate();
    await tester.pump();

    expect(find.text('Vul alsjeblieft je code in.'), findsOneWidget);
    expect(find.text('Vul alsjeblieft je geboortedatum in.'), findsOneWidget);
  });

  testWidgets('Login validate form with invalid date',
      (WidgetTester tester) async {
    var formKey = GlobalKey<FormState>();
    TextEditingController loginCodeController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();

    // Act
    await tester.pumpWidget(materialApp(
      Login(
        viewModel: const LoginViewModel(),
        formKey: formKey,
        onShowLoginInformationClicked: (context) {},
        loginCodeController: loginCodeController,
        birthDateController: birthDateController,
        onSubmitLogin: () {},
      ),
    ));

    await tester.enterText(find.byType(TextFormField).at(6), '01-13-2000');

    var formState = tester.state<FormState>(find.byType(Form));
    formState.validate();
    await tester.pump();

    expect(birthDateController.text.trim(), '01-13-2000');
    expect(find.text('Vul alsjeblieft je geboortedatum in.'), findsOneWidget);
  });

  testWidgets('Login submit form when enter is pressed inside form input',
      (WidgetTester tester) async {
    var formKey = GlobalKey<FormState>();
    TextEditingController loginCodeController =
        TextEditingController(text: 'ZBJFTW');
    TextEditingController birthDateController =
        TextEditingController(text: '01-01-2000');

    var submitCallbackCalled = false;

    // Act
    await tester.pumpWidget(materialApp(
      Login(
        viewModel: const LoginViewModel(),
        formKey: formKey,
        onShowLoginInformationClicked: (context) {},
        loginCodeController: loginCodeController,
        birthDateController: birthDateController,
        onSubmitLogin: () {
          submitCallbackCalled = true;
        },
      ),
    ));

    await tester.enterText(find.byType(TextFormField).at(0), 'Z');
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(submitCallbackCalled, true);
  });

  testWidgets('Login show authentication error', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(materialApp(
      Login(
        viewModel: const LoginViewModel(error: LoginError.authenticationError),
        formKey: GlobalKey<FormState>(),
        onShowLoginInformationClicked: (context) {},
        loginCodeController: TextEditingController(),
        birthDateController: TextEditingController(),
        onSubmitLogin: () {},
      ),
    ));

    expect(find.byType(ZbjRichText), findsOneWidget);
    expect(find.text('Dit account wordt niet herkend'), findsOneWidget);
  });

  testWidgets('Login show unexpected error', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(materialApp(
      Login(
        viewModel: const LoginViewModel(error: LoginError.unexpectedError),
        formKey: GlobalKey<FormState>(),
        onShowLoginInformationClicked: (context) {},
        loginCodeController: TextEditingController(),
        birthDateController: TextEditingController(),
        onSubmitLogin: () {},
      ),
    ));

    expect(find.byType(ZbjRichText), findsOneWidget);
    expect(find.text('Onverwachte fout opgetreden'), findsOneWidget);
  });
}
