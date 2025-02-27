import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

import 'helpers.dart';

void main() {
  testWidgets('Should contain the steps amount of bars', (tester) async {
    PageController controller = PageController();
    await tester.pumpWidget(materialAppWithTokens(
      tokens: DefaultTokens(),
      child: Localizations(
        locale: const Locale('nl'),
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        child: ZbjStatusBar(pageController: controller, steps: 5, step: 1),
      ),
    ));
    var indicatorFinder = find.byType(SmoothPageIndicator);

    expect(indicatorFinder, findsOne);
  });

  testWidgets('Should read the current page for accessibility', (tester) async {
    int step = 3;
    int pages = 5;
    PageController controller = PageController();
    await tester.pumpWidget(materialAppWithTokens(
      tokens: DefaultTokens(),
      child: Localizations(
        locale: const Locale('nl'),
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        child:
            ZbjStatusBar(pageController: controller, steps: pages, step: step),
      ),
    ));

    expect(tester.getSemantics(find.byType(ZbjStatusBar)).label,
        'Stap $step van $pages, actief');
  });
}
