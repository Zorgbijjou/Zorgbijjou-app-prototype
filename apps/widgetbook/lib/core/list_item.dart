import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Default',
    type: ListItem,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildListItemUseCase(BuildContext context) {
  return Container(
      color: context.knobs.boolean(label: 'Inverted')
          ? context.tokens.color.tokensTurqoise600
          : context.tokens.color.tokensWhite,
      child: ListItem(
        title: context.knobs.string(label: 'Title', initialValue: 'List Item'),
        position: context.knobs
            .list(
                label: 'Position',
                options: [
                  (label: 'First', position: ListItemPosition.first),
                  (label: 'Middle', position: ListItemPosition.middle),
                  (label: 'Last', position: ListItemPosition.last)
                ],
                labelBuilder: (item) => item.label)
            .position,
        onTap: () {},
        inverted: context.knobs.boolean(label: 'Inverted'),
      ));
}

@widgetbook.UseCase(
    name: 'List of List Items',
    type: ListItem,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildListOfListItemsUseCase(BuildContext context) {
  var labels = [
    'Ik heb geen e-mail van Luscii gekregen, wat nu?',
    'Is thuismeten van Zorg bij jou gratis?',
    'Kan ik ook weer stoppen met thuismeten?'
  ];
  var items = labels
      .map((label) => ListItem(
            title: label,
            position: labels.getListItemPosition(label),
            onTap: () {},
            inverted: context.knobs.boolean(label: 'Inverted'),
          ))
      .toList();

  return Container(
      color: context.knobs.boolean(label: 'Inverted')
          ? context.tokens.color.tokensTurqoise600
          : context.tokens.color.tokensWhite,
      child: ListView.separated(
          itemBuilder: (context, index) => items[index],
          separatorBuilder: (context, index) => CustomDivider.standard(),
          itemCount: items.length));
}

// One for inverted list of items, put it on a dark background
@widgetbook.UseCase(
    name: 'Inverted List of List Items',
    type: ListItem,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildInvertedListOfListItemsUseCase(BuildContext context) {
  var labels = [
    'Ik heb geen e-mail van Luscii gekregen, wat nu?',
    'Is thuismeten van Zorg bij jou gratis?',
    'Kan ik ook weer stoppen met thuismeten?'
  ];
  var items = labels
      .map((label) => ListItem(
            title: label,
            position: labels.getListItemPosition(label),
            onTap: () {},
            inverted: true,
          ))
      .toList();

  return Container(
      color: context.tokens.color.tokensTurqoise600,
      child: ListView.separated(
          itemBuilder: (context, index) => items[index],
          separatorBuilder: (context, index) => CustomDivider.inverted(),
          itemCount: items.length));
}
