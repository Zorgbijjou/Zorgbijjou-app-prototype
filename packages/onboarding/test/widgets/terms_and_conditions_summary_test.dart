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
  testWidgets('Conditions Summary displays items and button correctly',
      (WidgetTester tester) async {
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
          child: TermsAndConditionsSummary(
            onTermsAndConditionsClicked: (_) {},
            onContinue: () {},
          ),
        ),
      ),
    ));

    // Assert
    expect(find.text('We hebben je toestemming nodig'), findsOneWidget);
    expect(
        find.text(
            'Je gegevens zijn te zien voor de verpleegkundigen en je behandelaar.'),
        findsOneWidget);
    expect(find.byType(Icon), findsExactly(2));
    expect(find.byType(Button), findsOneWidget);
  });

  testWidgets('Terms and Conditions should show the all conditions',
      (WidgetTester tester) async {
    var mockOnSupportQuestionClicked = MockFunction();

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
          child: TermsAndConditionsSummary(
            onContinue: () {},
            onTermsAndConditionsClicked: (BuildContext context) {
              mockOnSupportQuestionClicked.call();
            },
          ),
        ),
      ),
    ));

    // Act
    await tester.tap(find.text('Lees alle voorwaarden'));

    // Assert
    verify(() => mockOnSupportQuestionClicked()).called(1);
  });
}
