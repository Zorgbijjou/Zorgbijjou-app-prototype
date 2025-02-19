import 'package:core/widgets/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Default',
    type: StatusBar,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=245-9182&t=pDuP8TaChj5gRobi-0',
    path: 'Core')
Widget buildDefaultStatusBarUseCase(BuildContext context) {
  int index = context.knobs.int.input(label: 'active step', initialValue: 1);
  int steps = context.knobs.int.input(label: 'steps', initialValue: 5);

  PageController controller = PageController(initialPage: index - 1);

  return PageView(
    controller: controller,
    children: List.generate(
      steps,
      (index) => StatusBar(
        pageController: controller,
        steps: steps,
        step: index + 1,
      ),
    ),
  );
}
