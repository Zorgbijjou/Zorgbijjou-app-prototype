import 'package:core/l10n/core_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/widgets/multiple_apps_introduction.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  testWidgets(
      'Multiple apps introduction displays header and items with icons correctly',
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
          child: MultipleAppsIntroduction(onContinue: () {}),
        ),
      ),
    ));

    // Assert
    expect(find.text('Welkom! Samen houden we jouw gezondheid in de gaten'),
        findsOneWidget);
    expect(
        find.text(
            'Voor je behandeling heb je twee apps nodig. We leggen je graag uit wat je met deze apps kan.'),
        findsOneWidget);

    var image = find.byType(Image);
    expect(image, findsOneWidget);

    expect(
      tester.getSemantics(image).label,
      contains(
          'Afbeelding van twee app-iconen: de eerste met de naam \'Zorg bij jou\' en de tweede met de naam \'Thuismeten\'.'),
    );
  });
}
