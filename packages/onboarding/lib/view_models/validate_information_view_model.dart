import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_information_view_model.freezed.dart';

@freezed
class ValidateInformationViewModel with _$ValidateInformationViewModel {
  const factory ValidateInformationViewModel({
    @Default('') String hospitalName,
    @Default('') String departmentName,
    @Default('') String treatmentName,
    @Default('') String patientName,
  }) = _ValidateInformationViewModel;

  const ValidateInformationViewModel._();
}
