import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

import 'navigation_bar_item.dart';

class ZbjNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<ZbjNavigationBarItem> items;

  const ZbjNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      decoration: BoxDecoration(
        color: context.tokens.color.tokensWhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          return Expanded(
            child: ZbjNavigationBarItemWidget(
              icon: item.icon,
              label: item.label,
              isSelected: index == selectedIndex,
              onDestinationSelected: onDestinationSelected,
              index: index,
              totalItems: items.length,
              showNotificationBubble: item.showNotificationBubble,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ZbjNavigationBarItem {
  final IconData icon;
  final String label;
  final bool showNotificationBubble;

  ZbjNavigationBarItem({
    required this.icon,
    required this.label,
    required this.showNotificationBubble,
  });
}
