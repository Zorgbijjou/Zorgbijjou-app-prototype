import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/icons.dart';

String labelKnob(BuildContext context) {
  return context.knobs.string(
    label: 'Label',
    initialValue:
        'Lorem ipsum dolor sit amet consectetur. Dignissim elementum porttitor sit eget neque.',
  );
}

@widgetbook.UseCase(
    name: 'Default',
    type: BulletItem,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=570-3625&node-type=FRAME',
    path: 'Core')
Widget buildBulletItemUseCase(BuildContext context) {
  return Container(
    color: context.tokens.color.tokensWhite,
    child: BulletItem.bullet(
      label: labelKnob(context),
    ),
  );
}

@widgetbook.UseCase(
    name: 'Icon',
    type: BulletItem,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=570-3625&node-type=FRAME',
    path: 'Core')
Widget buildBulletIconItemUseCase(BuildContext context) {
  return Container(
    color: context.tokens.color.tokensWhite,
    child: BulletItem.icon(
      label: labelKnob(context),
      icon: iconKnob(context: context),
    ),
  );
}

@widgetbook.UseCase(
    name: 'Extra',
    type: BulletItem,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=570-3625&node-type=FRAME',
    path: 'Core')
Widget buildExtraIconItemUseCase(BuildContext context) {
  return Container(
    color: context.tokens.color.tokensWhite,
    child: BulletItem.extra(
      label: labelKnob(context),
      icon: iconKnob(context: context),
      iconBackgroundColor: context.knobs.color(
        label: 'Icon Background Color',
        initialValue: context.tokens.color.tokensGrey100,
      ),
    ),
  );
}
