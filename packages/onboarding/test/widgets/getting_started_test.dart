import 'package:core/l10n/core_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/widgets/getting_started.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  testWidgets('Getting Started displays header and items with icons correctly',
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
          child: GettingStarted(onContinue: (_) {}),
        ),
      ),
    ));

    // Assert
    expect(
        find.text('Download de Thuismeten app om te beginnen'), findsOneWidget);
    expect(
        find.text(
            'De laatste stap is zorgen dat je de Thuismeten-app geïnstalleerd hebt staan op je telefoon.'),
        findsOneWidget);

    expect(
        find.text(
            'Heb je de Thuismeten-app al geïnstalleerd? Ga dan direct aan de slag met meten in de Zorg bij jou-app.'),
        findsOneWidget);

    expect(
        find.text(
            'Nog niet de Thuismeten-app geïnstalleerd? Check je e-mail (ook ongewenste e-mail) voor de uitnodiging van Luscii, de ontwikkelaar van de Thuismeten-app, en volg de instructies.'),
        findsOneWidget);
  });
}
