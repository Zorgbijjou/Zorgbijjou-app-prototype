import 'package:core/l10n/core_localizations.dart';
import 'package:core/widgets/stacked_button.dart';
import 'package:faq/widgets/contact_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MockFunction extends Mock {
  void call(String slug);
}

void main() {
  testWidgets('ContactFooter displays buttons and text',
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
          child: ContactFooter(),
        ),
      ),
    ));

    // Assert
    expect(find.text('Heb je een andere vraag?'), findsOneWidget);
    expect(find.text('Bel ons'), findsOneWidget);
    expect(find.image(const AssetImage('packages/faq/assets/images/faq.png')),
        findsOneWidget);
    expect(find.widgetWithIcon(ZbjStackedButton, CustomIcons.phone),
        findsOneWidget);
    expect(find.widgetWithIcon(ZbjStackedButton, CustomIcons.message_square_02),
        findsOneWidget);
  });
}
