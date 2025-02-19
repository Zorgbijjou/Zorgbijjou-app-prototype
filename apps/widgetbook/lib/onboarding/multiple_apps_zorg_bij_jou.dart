import 'package:flutter/material.dart';
import 'package:onboarding/widgets/multiple_apps_zorg_bij_jou.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Page',
  type: MultipleAppsZorgBijJou,
  path: 'Onboarding',
)
Widget buildUseCase(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    child: SafeArea(
      child: MultipleAppsZorgBijJou(
        onContinue: () {},
      ),
    ),
  );
}
