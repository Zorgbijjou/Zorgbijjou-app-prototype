import 'package:core/widgets/notification_banner.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Negative',
    type: NotificationBanner,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Pill-Components?node-id=9509-4628&t=d4pVCOhWHA8dSxo0-0',
    path: 'Core')
Widget buildNotificationBannerNegativeUseCase(BuildContext context) {
  return NotificationBanner.negative(
    title: context.knobs.string(label: 'Title', initialValue: 'Heading'),
    content: context.knobs.string(
        label: 'Content',
        initialValue:
            'Lorem ipsum dolor sit amet, consectetur ad * isicing elit, sed do eiusmod *'),
  );
}

@widgetbook.UseCase(
    name: 'Positive',
    type: NotificationBanner,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Pill-Components?node-id=9509-4628&t=d4pVCOhWHA8dSxo0-0',
    path: 'Core')
Widget buildNotificationBannerPositiveUseCase(BuildContext context) {
  return NotificationBanner.positive(
    title: context.knobs.string(label: 'Title', initialValue: 'Heading'),
    content: context.knobs.string(
        label: 'Content',
        initialValue:
            'Lorem ipsum dolor sit amet, consectetur ad * isicing elit, sed do eiusmod *'),
  );
}
