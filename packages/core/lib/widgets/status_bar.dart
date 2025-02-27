import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

import '../l10n/core_localizations.dart';

class ZbjStatusBar extends StatelessWidget {
  final PageController pageController;
  final int step;
  final int steps;

  const ZbjStatusBar({
    super.key,
    required this.pageController,
    required this.step,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: AppLocalizations.of(context)!
          .statusBarAccessibilityLabel(step, steps),
      readOnly: true,
      child: SmoothPageIndicator(
        controller: pageController, // PageController
        count: steps,
        effect: ExpandingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          radius: 12,
          spacing: 4,
          dotColor: context.tokens.color.tokensGrey200,
          activeDotColor: context.tokens.color.tokensTurqoise500,
        ),
      ),
    );
  }
}
