import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/view_models/onboarding_view_model.dart';
import 'package:theme/theme.dart';

class MultipleAppsIntroduction extends OnboardingComponent {
  final Function onContinue;

  MultipleAppsIntroduction({required this.onContinue, Key? key})
      : super(globalKey: GlobalKey());

  @override
  OnboardingComponentState<MultipleAppsIntroduction> createState() =>
      _MultipleAppsIntroductionState();
}

class _MultipleAppsIntroductionState
    extends OnboardingComponentState<MultipleAppsIntroduction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!
                    .onboardingMultipleAppsIntroductionHeader,
                style: context.tokens.textStyle.tokensTypographyHeadingXl,
              ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!
                    .onboardingMultipleAppsIntroductionParagraph,
                style: context.tokens.textStyle.tokensTypographyParagraphMd,
              ),
            ],
          ),
        ),
        buildMultipleAppsImage(context),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildMultipleAppsImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          var containerMaxWidth = constraints.maxWidth;
          var imageWidth = min(containerMaxWidth, 376.0);
          var imageHeight = imageWidth * 0.7;

          // The SizedBox here makes sure that during transition from previous onboarding component to this one
          // The image does not make the transition jump
          return SizedBox(
            height: imageHeight,
            width: imageWidth,
            child: Semantics(
              label: AppLocalizations.of(context)!
                  .onboardingMultipleAppsIntroductionImage,
              child: Image.asset(
                'packages/onboarding/assets/images/multiple-apps-explanation.png',
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildActionButton(BuildContext context) {
    return ZbjIconButton.brand(
      tooltip: AppLocalizations.of(context)!.nextButtonAccessibilityLabel,
      icon: const Icon(CustomIcons.arrow_right),
      onPressed: () => widget.onContinue(),
    );
  }
}
