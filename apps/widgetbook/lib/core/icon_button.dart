import 'package:core/widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../icons.dart';

@widgetbook.UseCase(
    name: 'Brand',
    type: ZbjIconButton,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildBrandIconButtonUseCase(BuildContext context) {
  return ZbjIconButton.brand(
    onPressed: () {},
    icon: iconKnob(context: context),
    tooltip: tooltipKnop(context),
  );
}

@widgetbook.UseCase(
    name: 'Primary',
    type: ZbjIconButton,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildPrimaryIconButtonUseCase(BuildContext context) {
  return ZbjIconButton.primary(
    onPressed: () {},
    icon: iconKnob(context: context),
    tooltip: tooltipKnop(context),
  );
}

@widgetbook.UseCase(
    name: 'Secondary',
    type: ZbjIconButton,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildSecondaryIconButtonUseCase(BuildContext context) {
  return ZbjIconButton.secondary(
    onPressed: () {},
    icon: iconKnob(context: context),
    tooltip: tooltipKnop(context),
  );
}

@widgetbook.UseCase(
    name: 'Subtle',
    type: ZbjIconButton,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildSubtleIconButtonUseCase(BuildContext context) {
  return ZbjIconButton.subtle(
    onPressed: () {},
    icon: iconKnob(context: context),
    tooltip: tooltipKnop(context),
  );
}

String tooltipKnop(BuildContext context) {
  return context.knobs.string(label: 'Tooltip', initialValue: 'Tooltip Action');
}
