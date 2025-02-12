import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Page',
  type: LoginInformation,
  path: 'Onboarding',
)
Widget buildTermsAndConditionsPageUseCase(BuildContext context) {
  var locale = Localizations.localeOf(context);

  return LoginInformation(
    content: mockLoginInformationContent[locale.languageCode],
    onBackClicked: (_) {},
  );
}
