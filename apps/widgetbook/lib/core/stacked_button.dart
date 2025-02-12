import 'package:core/widgets/stacked_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../icons.dart';

@widgetbook.UseCase(
    name: 'Default',
    type: StackedButton,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=295-1702&t=HgY7INLlyFlOalMa-0',
    path: 'Core')
Widget buildDefaultButtonUseCase(BuildContext context) {
  return StackedButton.primary(
    label: context.knobs.string(label: 'Label', initialValue: 'Label'),
    onPressed: () {},
    fill: context.knobs.boolean(label: 'Fill', initialValue: false),
    icon: iconKnob(context: context),
  );
}
