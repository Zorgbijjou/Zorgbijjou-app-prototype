import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/view_models/onboarding_view_model.dart';
import 'package:theme/theme.dart';

class GettingStarted extends OnboardingComponent {
  final Function(BuildContext context) onContinue;

  GettingStarted({required this.onContinue, Key? key})
      : super(globalKey: GlobalKey());

  @override
  OnboardingComponentState<GettingStarted> createState() =>
      _GettingStartedState();
}

class _GettingStartedState extends OnboardingComponentState<GettingStarted> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 24, bottom: 16, left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.onboardingGettingStartedHeader,
            style: context.tokens.textStyle.tokensTypographyHeadingXl,
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.onboardingGettingStartedParagraph1,
            style: context.tokens.textStyle.tokensTypographyParagraphMd,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.onboardingGettingStartedParagraph2,
            style: context.tokens.textStyle.tokensTypographyParagraphMd,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.onboardingGettingStartedParagraph3,
            style: context.tokens.textStyle.tokensTypographyParagraphMd,
          ),
        ],
      ),
    );
  }

  @override
  Widget buildActionButton(BuildContext context) {
    return Button.brand(
      onPressed: () => widget.onContinue(context),
      label: AppLocalizations.of(context)!.onboardingGettingStartedButton,
    );
  }
}
