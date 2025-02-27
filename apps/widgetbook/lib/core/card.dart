import 'package:core/core.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Default',
    type: ZbjCard,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildPrimaryCardUseCase(BuildContext context) {
  return ZbjCard.primary(
    title: context.knobs
        .string(label: 'Title', initialValue: 'Hoe werkt thuismeten?'),
    subTitle: context.knobs.string(label: 'Subtitle', initialValue: '1 vraag'),
    body: context.knobs.boolean(label: 'With body', initialValue: true)
        ? const Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            Icon(
              Icons.access_time_rounded,
              size: 16,
            ),
            SizedBox(width: 8),
            Text('Meta'),
          ])
        : null,
    image: context.knobs.boolean(label: 'With image', initialValue: true)
        ? const AssetImage('assets/images/beestjes.png')
        : null,
    onTap: () {},
  );
}

@widgetbook.UseCase(
    name: 'Large',
    type: ZbjCard,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=280-6626&t=KyUC7FDzDlyaS9rU-0',
    path: 'Core')
Widget buildLargeCardUseCase(BuildContext context) {
  return ZbjCard.large(
    title: context.knobs
        .string(label: 'Title', initialValue: 'Hoe werkt thuismeten?'),
    subTitle: context.knobs.string(label: 'Subtitle', initialValue: '1 vraag'),
    label: context.knobs.boolean(label: 'With Label', initialValue: true)
        ? const ZbjLabel(label: 'Label', icon: Icons.workspace_premium_outlined)
        : null,
    body: context.knobs.boolean(label: 'With body', initialValue: true)
        ? const Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            Icon(Icons.access_time_rounded, size: 16),
            SizedBox(width: 8),
            Text('Meta'),
          ])
        : null,
    image: context.knobs.boolean(label: 'With image', initialValue: true)
        ? const AssetImage('assets/images/beestjes.png')
        : null,
    onTap: () {},
  );
}
