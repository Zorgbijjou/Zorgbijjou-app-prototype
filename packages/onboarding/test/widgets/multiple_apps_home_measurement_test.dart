import 'package:core/l10n/core_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onboarding/widgets/multiple_apps_home_measurement.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

void main() {
  testWidgets(
      'Multiple apps home measurement displays header and items with icons correctly',
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
          child: MultipleAppsHomeMeasurement(onContinue: () {}),
        ),
      ),
    ));

    // Assert
    expect(find.text('Thuismeten'), findsOneWidget);
    expect(
        find.text(
            'De Thuismeten app helpt je bij het in de gaten houden van je gezondheid:'),
        findsOneWidget);
    expect(find.text('Zelf metingen doorgeven.'), findsOneWidget);
    expect(
        find.text(
            'Geef je gemeten waardes door, zoals je bloedglucose, om je diabetes in de gaten te houden.'),
        findsOneWidget);
    expect(find.text('Krijg advies.'), findsOneWidget);
    expect(
        find.text(
            'Met jouw antwoorden en metingen geeft de app je meteen feedback en advies om je diabetes onder controle te houden.'),
        findsOneWidget);
    expect(find.byType(Icon), findsExactly(2));
  });
}
