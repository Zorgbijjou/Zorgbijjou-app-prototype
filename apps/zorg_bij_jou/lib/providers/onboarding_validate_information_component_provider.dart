import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding/view_models/validate_information_view_model.dart';

final onboardingValidateInformationViewModelProvider =
    StateNotifierProvider.autoDispose<
            OnboardingValidateInformationViewModelStateNotifier,
            ValidateInformationViewModel>(
        (ref) => OnboardingValidateInformationViewModelStateNotifier());

class OnboardingValidateInformationViewModelStateNotifier
    extends StateNotifier<ValidateInformationViewModel> {
  OnboardingValidateInformationViewModelStateNotifier()
      : super(
          const ValidateInformationViewModel(
            hospitalName: 'Martini Ziekenhuis',
            departmentName: 'Gynaecologie',
            treatmentName: 'Zwangerschapsdiabetes',
            patientName: 'Jeroen Drouwen',
          ),
        );
}
