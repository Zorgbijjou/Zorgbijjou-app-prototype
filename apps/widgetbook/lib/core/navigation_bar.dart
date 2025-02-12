import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

List<ZbjNavigationBarItem> buildNavigationBarItems(BuildContext context) {
  return [
    ZbjNavigationBarItem(
      icon: Icons.home,
      label: 'Home',
      showNotificationBubble: context.knobs
          .boolean(label: 'Home notification bubble', initialValue: true),
    ),
    ZbjNavigationBarItem(
      icon: Icons.search,
      label: 'Search',
      showNotificationBubble:
          context.knobs.boolean(label: 'Search bubble', initialValue: false),
    ),
    ZbjNavigationBarItem(
      icon: Icons.settings,
      label: 'Settings',
      showNotificationBubble:
          context.knobs.boolean(label: 'Settings bubble', initialValue: false),
    ),
  ];
}

@widgetbook.UseCase(
  name: 'Custom Navigation Bar',
  type: ZbjNavigationBar,
  designLink:
      'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
  path: 'Core',
)
Widget buildNavigationBarUseCase(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: ZbjNavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (index) {},
      items: buildNavigationBarItems(context),
    ),
    body: const Placeholder(),
  );
}

@widgetbook.UseCase(
  name: 'Custom Navigation Bar with Scrollable Content',
  type: ZbjNavigationBar,
  designLink:
      'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
  path: 'Core',
)
Widget buildNavigationBarWithScrollableContentUseCase(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: ZbjNavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (index) {},
      items: buildNavigationBarItems(context),
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
