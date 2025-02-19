import 'package:flutter/material.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:widgetbook/widgetbook.dart';

var icons = [
  ['sunny', Icons.sunny],
  ['arrow_right', CustomIcons.arrow_right],
  ['help_circle', CustomIcons.help_circle],
  ['message_text_square_02', CustomIcons.message_text_square_02],
];

var iconAligments = [
  (label: 'start', alignment: IconAlignment.start),
  (label: 'end', alignment: IconAlignment.end)
];

List<({String label, Icon widget})> iconList(
  double? size,
) {
  return icons
      .map((icon) => (
            label: icon[0] as String,
            widget: Icon(icon[1] as IconData, size: size)
          ))
      .toList();
}

List<({String label, IconData widget})> iconDataList() {
  return icons
      .map((icon) => (label: icon[0] as String, widget: icon[1] as IconData))
      .toList();
}

Icon iconKnob({
  required BuildContext context,
  String label = 'Icon',
  double? size,
  int initialOption = 0,
}) {
  return context.knobs
      .list(
          label: label,
          options: iconList(size),
          labelBuilder: (item) => item.label)
      .widget;
}

IconData? iconDataKnob({
  required BuildContext context,
  String label = 'Icon',
  double? size,
  int initialOption = 0,
}) {
  return context.knobs
      .list(
          label: label,
          options: iconDataList(),
          labelBuilder: (item) => item.label)
      .widget;
}

IconAlignment iconAlignmentKnob({
  required BuildContext context,
  String label = 'Icon alignment',
}) {
  return context.knobs
      .list(
          label: 'Icon alignment',
          options: iconAligments,
          labelBuilder: (item) => item.label)
      .alignment;
}

bool iconEnabledKnob({
  required BuildContext context,
  label = 'IconEnabled',
  initialValue = false,
}) {
  return context.knobs.boolean(label: label, initialValue: initialValue);
}
