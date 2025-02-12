import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/view_models/onboarding_view_model.dart';
import 'package:theme/theme.dart';

class TermsAndConditionsSummary extends OnboardingComponent {
  final Function(BuildContext context) onTermsAndConditionsClicked;
  final Function onContinue;

  TermsAndConditionsSummary({
    required this.onTermsAndConditionsClicked,
    required this.onContinue,
  }) : super(globalKey: GlobalKey());

  @override
  OnboardingComponentState<TermsAndConditionsSummary> createState() =>
      _TermsAndConditionsSummaryState();
}

class _TermsAndConditionsSummaryState
    extends OnboardingComponentState<TermsAndConditionsSummary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 24, bottom: 16, left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.onboardingConditionsHeader,
            style: context.tokens.textStyle.tokensTypographyHeadingLg,
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.onboardingConditionsExplanation,
            style: context.tokens.textStyle.tokensTypographyParagraphMd,
          ),
          const SizedBox(height: 24),
          BulletItem.icon(
            label: AppLocalizations.of(context)!.onboardingConditionsItem2,
            icon: Icon(
              CustomIcons.glasses_02,
              color: context.tokens.color.tokensTurqoise600,
            ),
          ),
          const SizedBox(height: 16),
          BulletItem.icon(
            label: AppLocalizations.of(context)!.onboardingConditionsItem3,
            icon: Icon(
              CustomIcons.lock_01,
              color: context.tokens.color.tokensTurqoise600,
            ),
          ),
          const SizedBox(height: 16),
          Button.subtle(
            label:
                AppLocalizations.of(context)!.onboardingConditionsReadAllButton,
            onPressed: () {
              widget.onTermsAndConditionsClicked(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildActionButton(BuildContext context) {
    return Button.brand(
      onPressed: () {
        customEvent('Terms and conditions accepted');
        widget.onContinue();
      },
      label: AppLocalizations.of(context)!.onboardingConditionsAgreeButton,
    );
  }
}
