import 'package:flutter/material.dart';
import 'package:onboarding/widgets/multiple_apps_introduction.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Page',
  type: MultipleAppsIntroduction,
  path: 'Onboarding',
)
Widget buildUseCase(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    child: SafeArea(
      child: MultipleAppsIntroduction(
        onContinue: () {},
      ),
    ),
  );
}
