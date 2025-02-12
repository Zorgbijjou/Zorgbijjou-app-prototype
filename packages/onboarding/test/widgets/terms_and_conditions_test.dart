import 'package:core/l10n/core_localizations.dart';
import 'package:core/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/widgets/terms_and_conditions.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  testWidgets('Conditions Summary show full conditions page',
      (WidgetTester tester) async {
    String termsAndConditionsContent =
        'De informatie die je via de app invult, is medische informatie.';

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
          child: TermsAndConditions(
            content: termsAndConditionsContent,
            onBackClicked: (_) {},
          ),
        ),
      ),
    ));

    expect(find.text('Complete voorwaarden'), findsOneWidget);
    expect(
        find.text(
            'De informatie die je via de app invult, is medische informatie.'),
        findsOneWidget);
    expect(find.byType(Button), findsOneWidget);
  });

  testWidgets('Terms and Conditions should show the all conditions',
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
          child: TermsAndConditions(
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
