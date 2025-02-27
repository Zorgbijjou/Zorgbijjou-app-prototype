import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/view_models/onboarding_view_model.dart';
import 'package:theme/theme.dart';

class MultipleAppsZorgBijJou extends OnboardingComponent {
  final Function onContinue;

  MultipleAppsZorgBijJou({required this.onContinue, Key? key})
      : super(globalKey: GlobalKey());

  @override
  OnboardingComponentState<MultipleAppsZorgBijJou> createState() =>
      _MultipleAppsZorgBijJouState();
}

class _MultipleAppsZorgBijJouState
    extends OnboardingComponentState<MultipleAppsZorgBijJou> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Image.asset(
                  'packages/onboarding/assets/images/zorg-bij-jou-app-icon.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  AppLocalizations.of(context)!
                      .onboardingMultipleAppsZorgBijJouHeader,
                  style: context.tokens.textStyle.tokensTypographyHeadingXl,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!
                .onboardingMultipleAppsZorgBijJouParagraph,
            style: context.tokens.textStyle.tokensTypographyParagraphMd,
          ),
          const SizedBox(height: 24),
          ZbjBulletItem.extra(
            title: AppLocalizations.of(context)!
                .onboardingMultipleAppsZorgBijJouItem1Title,
            label: AppLocalizations.of(context)!
                .onboardingMultipleAppsZorgBijJouItem1Description,
            icon: Icon(
              CustomIcons.message_square_02,
              color: context.tokens.color.tokensTurqoise600,
            ),
            iconBackgroundColor: context.tokens.color.tokensTurqoise50,
          ),
          const SizedBox(height: 16),
          ZbjBulletItem.extra(
            title: AppLocalizations.of(context)!
                .onboardingMultipleAppsZorgBijJouItem2Title,
            label: AppLocalizations.of(context)!
                .onboardingMultipleAppsZorgBijJouItem2Description,
            icon: Icon(
              CustomIcons.help_circle,
              color: context.tokens.color.tokensTurqoise600,
            ),
            iconBackgroundColor: context.tokens.color.tokensTurqoise50,
          ),
        ],
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
