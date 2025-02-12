import 'package:core/widgets/navigation_bar.dart';
import 'package:core/widgets/navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers.dart';

class MockCallback extends Mock {
  void call(int index);
}

void main() {
  group('ZbjNavigationBar', () {
    testWidgets('Should display the correct number of items', (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          bottomNavigationBar: ZbjNavigationBar(
            selectedIndex: 0,
            onDestinationSelected: (_) {},
            items: [
              ZbjNavigationBarItem(
                  icon: Icons.home,
                  label: 'Home',
                  showNotificationBubble: false),
              ZbjNavigationBarItem(
                  icon: Icons.search,
                  label: 'Search',
                  showNotificationBubble: false),
            ],
          ),
        ),
      ));

      var homeFinder = find.text('Home');
      var searchFinder = find.text('Search');

      expect(homeFinder, findsOneWidget);
      expect(searchFinder, findsOneWidget);
    });

    testWidgets('Should highlight the selected item', (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          bottomNavigationBar: ZbjNavigationBar(
            selectedIndex: 1,
            onDestinationSelected: (_) {},
            items: [
              ZbjNavigationBarItem(
                  icon: Icons.home,
                  label: 'Home',
                  showNotificationBubble: false),
              ZbjNavigationBarItem(
                  icon: Icons.search,
                  label: 'Search',
                  showNotificationBubble: false),
            ],
          ),
        ),
      ));

      var selectedFinder = find.byWidgetPredicate((widget) =>
          widget is ZbjNavigationBarItemWidget && widget.isSelected);

      expect(selectedFinder, findsOneWidget);
    });

    testWidgets('Should call onDestinationSelected with correct index',
        (tester) async {
      var mockCallback = MockCallback();

      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          bottomNavigationBar: ZbjNavigationBar(
            selectedIndex: 0,
            onDestinationSelected: mockCallback.call,
            items: [
              ZbjNavigationBarItem(
                  icon: Icons.home,
                  label: 'Home',
                  showNotificationBubble: false),
              ZbjNavigationBarItem(
                  icon: Icons.search,
                  label: 'Search',
                  showNotificationBubble: false),
            ],
          ),
        ),
      ));

      var searchFinder = find.text('Search');
      await tester.tap(searchFinder);
      await tester.pump();

      verify(() => mockCallback(1)).called(1);
    });
  });
}
