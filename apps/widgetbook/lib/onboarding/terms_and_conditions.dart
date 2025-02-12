import 'package:flutter/material.dart';
import 'package:onboarding/mocks/mock_data_source.dart';
import 'package:onboarding/widgets/terms_and_conditions.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Page',
  type: TermsAndConditions,
  path: 'Onboarding',
)
Widget buildTermsAndConditionsPageUseCase(BuildContext context) {
  var locale = Localizations.localeOf(context);

  return TermsAndConditions(
    content: mockTermsAndConditionsContent[locale.languageCode],
    onBackClicked: (_) {},
  );
}
