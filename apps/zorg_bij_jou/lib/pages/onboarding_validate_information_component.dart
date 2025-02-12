import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/view_models/onboarding_view_model.dart';
import 'package:onboarding/widgets/validate_information.dart';
import 'package:zorg_bij_jou/providers/onboarding_validate_information_component_provider.dart';

class OnboardingValidateInformationComponent extends OnboardingComponent {
  final Function onContinue;

  OnboardingValidateInformationComponent({required this.onContinue, Key? key})
      : super(globalKey: GlobalKey());

  @override
  OnboardingComponentState<OnboardingValidateInformationComponent>
      createState() => _OnboardingValidateInformationComponentState();
}

class _OnboardingValidateInformationComponentState
    extends OnboardingComponentState<OnboardingValidateInformationComponent> {
  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(onboardingValidateInformationViewModelProvider);

    return ValidateInformation(
      viewModel: viewModel,
    );
  }

  @override
  Widget buildActionButton(BuildContext context) {
    return Button.brand(
      onPressed: () => widget.onContinue(),
      label: AppLocalizations.of(context)!.validateInformationNextButton,
    );
  }
}
