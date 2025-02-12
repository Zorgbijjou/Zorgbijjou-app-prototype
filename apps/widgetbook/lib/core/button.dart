import 'package:core/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../icons.dart';

@widgetbook.UseCase(
    name: 'Brand',
    type: Button,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildBrandButtonUseCase(BuildContext context) {
  return Button.brand(
    label: context.knobs.string(label: 'Label', initialValue: 'Label'),
    onPressed: () {},
    fill: context.knobs.boolean(label: 'Fill', initialValue: false),
    icon: iconEnabledKnob(context: context) ? iconKnob(context: context) : null,
    iconAlignment: iconAlignmentKnob(context: context),
  );
}

@widgetbook.UseCase(
    name: 'Primary',
    type: Button,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildPrimaryButtonUseCase(BuildContext context) {
  return Button.primary(
    label: context.knobs.string(label: 'Label', initialValue: 'Label'),
    onPressed: () {},
    fill: context.knobs.boolean(label: 'Fill', initialValue: false),
    icon: iconEnabledKnob(context: context) ? iconKnob(context: context) : null,
    iconAlignment: iconAlignmentKnob(context: context),
  );
}

@widgetbook.UseCase(
    name: 'Secondary',
    type: Button,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildSecondaryButtonUseCase(BuildContext context) {
  return Button.secondary(
    label: context.knobs.string(label: 'Label', initialValue: 'Label'),
    onPressed: () {},
    fill: context.knobs.boolean(label: 'Fill', initialValue: false),
    icon: iconEnabledKnob(context: context) ? iconKnob(context: context) : null,
    iconAlignment: iconAlignmentKnob(context: context),
  );
}

@widgetbook.UseCase(
    name: 'Subtle',
    type: Button,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildSubtleButtonUseCase(BuildContext context) {
  var iconEnabled =
      context.knobs.boolean(label: 'Icon Enabled', initialValue: false);

  return Button.subtle(
    label: context.knobs.string(label: 'Label', initialValue: 'Label'),
    cropped: context.knobs.boolean(label: 'Cropped', initialValue: false),
    onPressed: () {},
    fill: context.knobs.boolean(label: 'Fill', initialValue: false),
    icon: iconEnabled ? iconKnob(context: context) : null,
    iconAlignment: iconAlignmentKnob(context: context),
  );
}
