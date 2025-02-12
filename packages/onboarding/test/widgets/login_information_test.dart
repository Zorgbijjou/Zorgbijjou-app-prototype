import 'package:core/l10n/core_localizations.dart';
import 'package:core/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/onboarding.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  testWidgets('Login Information show content and back button',
      (WidgetTester tester) async {
    String content = 'Je kunt de app alleen gebruiken.';

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: LoginInformation(
            content: content,
            onBackClicked: (_) {},
          ),
        ),
      ),
    ));

    expect(find.text('Waar kan ik de code vinden?'), findsOneWidget);
    expect(find.text('Je kunt de app alleen gebruiken.'), findsOneWidget);
    expect(find.byType(Button), findsOneWidget);
  });

  testWidgets('Login Information should allow to go back',
      (WidgetTester tester) async {
    var mockOnSupportQuestionClicked = MockFunction();

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: LoginInformation(
            content: '',
            onBackClicked: (BuildContext context) {
              mockOnSupportQuestionClicked.call();
            },
          ),
        ),
      ),
    ));

    // Act
    await tester.tap(find.text('Terug'));

    // Assert
    verify(() => mockOnSupportQuestionClicked()).called(1);
  });
}
