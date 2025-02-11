import 'package:core/l10n/core_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/widgets/multiple_apps_zorg_bij_jou.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  testWidgets(
      'Multiple apps zorg bij jou displays header and items with icons correctly',
      (WidgetTester tester) async {
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
          child: MultipleAppsZorgBijJou(onContinue: () {}),
        ),
      ),
    ));

    // Assert
    expect(find.text('Zorg bij jou'), findsOneWidget);
    expect(find.text('Contact met verpleegkundigen.'), findsOneWidget);

    expect(find.text('De Zorg bij jou app (deze app) gebruik je voor:'),
        findsOneWidget);

    expect(find.text('Contact met verpleegkundigen.'), findsOneWidget);

    expect(
        find.text(
            'Heb je zorgen over een meting of andere gezondheidsvragen? Je kunt contact opnemen met de verpleegkundige via deze app. Ook nemen zij contact met jou op bij vragen.'),
        findsOneWidget);

    expect(find.text('Hulp bij vragen.'), findsOneWidget);

    expect(
        find.text(
            'Vind snel antwoorden op veelgestelde vragen over bijvoorbeeld het thuismeten en meer.'),
        findsOneWidget);

    expect(find.byType(Icon), findsExactly(2));
  });
}
