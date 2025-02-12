import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Standard',
    type: Divider,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=3378-6168&node-type=frame&t=GZ3YvJsiqjfSMCAB-0',
    path: 'Core')
Widget buildStandardDividerUseCase(BuildContext context) {
  return CustomDivider.standard();
}

@widgetbook.UseCase(
    name: 'Inverted',
    type: Divider,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=3378-6168&node-type=frame&t=GZ3YvJsiqjfSMCAB-0',
    path: 'Core')
Widget buildInvertedDividerUseCase(BuildContext context) {
  return CustomDivider.inverted();
}

@widgetbook.UseCase(
    name: 'Label',
    type: Divider,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=3378-6168&node-type=frame&t=GZ3YvJsiqjfSMCAB-0',
    path: 'Core')
Widget buildLabelDividerUseCase(BuildContext context) {
  return CustomDivider.label(
    label: context.knobs.string(label: 'Label', initialValue: 'Label'),
    color: context.knobs.color(
      label: 'Divider Color',
      initialValue: context.tokens.color.tokensTurqoise700,
    ),
  );
}
