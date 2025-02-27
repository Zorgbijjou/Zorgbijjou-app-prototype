import 'package:core/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../icons.dart';

@widgetbook.UseCase(
    name: 'Default',
    type: ZbjLabel,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=374-5527',
    path: 'Core')
Widget buildDefaultLabelUseCase(BuildContext context) {
  return ZbjLabel(
    label: context.knobs.string(label: 'Label', initialValue: 'Label'),
    icon: iconDataKnob(context: context),
  );
}
