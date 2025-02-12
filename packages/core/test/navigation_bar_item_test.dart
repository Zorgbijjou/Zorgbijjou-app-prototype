import 'package:core/shapes/dotted_border_shape.dart';
import 'package:core/widgets/navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

import 'helpers.dart';

class MockCallback extends Mock {
  void call(int index);
}

void main() {
  group('NavigationBarItem', () {
    testWidgets('Should display the correct icon and label', (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: ZbjNavigationBarItemWidget(
            icon: Icons.home,
            label: 'Home',
            isSelected: false,
            onDestinationSelected: (_) {},
            index: 0,
            totalItems: 1,
            showNotificationBubble: false,
          ),
        ),
      ));

      var iconFinder = find.byIcon(Icons.home);
      var labelFinder = find.text('Home');

      expect(iconFinder, findsOneWidget);
      expect(labelFinder, findsOneWidget);
    });

    testWidgets('Should highlight the selected item', (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: ZbjNavigationBarItemWidget(
            icon: Icons.home,
            label: 'Home',
            isSelected: true,
            onDestinationSelected: (_) {},
            index: 0,
            totalItems: 1,
            showNotificationBubble: false,
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
          body: ZbjNavigationBarItemWidget(
            icon: Icons.home,
            label: 'Home',
            isSelected: false,
            onDestinationSelected: mockCallback.call,
            index: 0,
            totalItems: 1,
            showNotificationBubble: false,
          ),
        ),
      ));

      var itemFinder = find.text('Home');
      await tester.tap(itemFinder);
      await tester.pump();

      verify(() => mockCallback(0)).called(1);
    });

    testWidgets(
        'Should handle keyboard interaction and call onDestinationSelected',
        (tester) async {
      var mockCallback = MockCallback();

      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: ZbjNavigationBarItemWidget(
            icon: Icons.home,
            label: 'Home',
            isSelected: false,
            onDestinationSelected: mockCallback.call,
            index: 0,
            totalItems: 1,
            showNotificationBubble: false,
          ),
        ),
      ));

      // first tab
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      var focusWidget = find.byKey(const Key('outlined_focus'));

      expect(focusWidget, findsOneWidget);
      expect(
          tester.widget<Material>(focusWidget).shape, isA<DottedBorderShape>());

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      verify(() => mockCallback(0)).called(1);
    });

    testWidgets('Should have correct semantics label when not selected',
        (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: ZbjNavigationBarItemWidget(
            icon: Icons.home,
            label: 'Home',
            isSelected: false,
            onDestinationSelected: (_) {},
            index: 0,
            totalItems: 2,
            showNotificationBubble: false,
          ),
        ),
      ));

      var semanticsHandle = tester.ensureSemantics();

      var semantics = tester.getSemantics(find.byType(InkWell));

      expect(
        semantics,
        matchesSemantics(
          label: 'Home\nTab 1 van de 2',
          isSelected: false,
        ),
      );

      semanticsHandle.dispose();
    });

    testWidgets('Should have correct semantics label when selected',
        (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: ZbjNavigationBarItemWidget(
            icon: Icons.home,
            label: 'Service',
            isSelected: true,
            onDestinationSelected: (_) {},
            index: 1,
            totalItems: 2,
            showNotificationBubble: false,
          ),
        ),
      ));

      var semanticsHandle = tester.ensureSemantics();

      var semantics = tester.getSemantics(find.byType(InkWell));

      expect(
        semantics,
        matchesSemantics(
          label: 'Service\nTab 2 van de 2',
          isSelected: true,
        ),
      );

      semanticsHandle.dispose();
    });

    testWidgets('Should display a notification bubble', (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: ZbjNavigationBarItemWidget(
            icon: Icons.home,
            label: 'Home',
            isSelected: false,
            onDestinationSelected: (_) {},
            index: 0,
            totalItems: 1,
            showNotificationBubble: true,
          ),
        ),
      ));

      var iconFinder = find.byIcon(Icons.home);

      expect(iconFinder, findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).color ==
                  DefaultTokens().color.tokensRed400),
          findsOneWidget);
    });
  });
}
