import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding/onboarding.dart';
import 'package:onboarding/view_models/validate_information_view_model.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: ValidateInformation,
  path: 'Onboarding',
)
Widget buildOnboardingPageUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);

  var viewModel = const ValidateInformationViewModel(
    hospitalName: 'Martini Ziekenhuis',
    departmentName: 'Gynaecologie',
    treatmentName: 'Zwangerschapsdiabetes',
    patientName: 'Jeroen Drouwen',
  );

  return FutureBuilder(
    future: localeDataSource.initializeLocales(['nl', 'en']),
    builder: (context, _) => Container(
      color: Colors.white,
      child: SafeArea(
        child: ValidateInformation(
          viewModel: viewModel,
        ),
      ),
    ),
  );
}
