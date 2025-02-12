import 'package:flutter/material.dart';
import 'package:onboarding/widgets/getting_started.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Page',
  type: GettingStarted,
  path: 'Onboarding',
)
Widget buildGettingStartedComponentUseCase(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    child: SafeArea(
      child: GettingStarted(
        onContinue: (_) {},
      ),
    ),
  );
}
