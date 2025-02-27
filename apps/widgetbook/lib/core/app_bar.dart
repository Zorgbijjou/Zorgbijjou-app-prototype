// widgetbook for AppBar Component

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Custom App Bar',
    type: AppBar,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildAppBarUseCase(BuildContext context) {
  return Scaffold(
    appBar: ZbjAppBar(
      onPressed: () {},
    ),
    // full height placeholder
    body: const Placeholder(),
  );
}

@widgetbook.UseCase(
    name: 'Custom App Bar with Scrollable Content',
    type: AppBar,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildAppBarWithScrollableContentUseCase(BuildContext context) {
  return Scaffold(
    appBar: ZbjAppBar(
      onPressed: () {},
    ),
    body: ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    ),
  );
}
