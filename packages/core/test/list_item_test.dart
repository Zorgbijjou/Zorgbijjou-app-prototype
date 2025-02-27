import 'package:core/shapes/dotted_border_shape.dart';
import 'package:core/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/theme.dart';

import 'helpers.dart';

class MockCallback extends Mock {
  void call();
}

void main() {
  group('ListItemPosition extension', () {
    test('should calculate the proper ListItemPosition for an item in a list',
        () {
      var someList = ['a', 'b', 'c', 'd'];

      expect(someList.getListItemPosition('a'), ZbjListItemPosition.first);
      expect(someList.getListItemPosition('b'), ZbjListItemPosition.middle);
      expect(someList.getListItemPosition('c'), ZbjListItemPosition.middle);
      expect(someList.getListItemPosition('d'), ZbjListItemPosition.last);
    });
  });

  group('ListItem', () {
    testWidgets('Should display a title', (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
          child: ZbjListItem(
        title: 'Test list item',
        onTap: () {},
      )));

      var formattedTextFinder = find.text('Test list item');

      expect(formattedTextFinder, findsOneWidget);
    });

    testWidgets('Should focus the ListItem when focused', (tester) async {
      // Create a FocusNode that will be passed to the ListItem
      FocusNode focusNode = FocusNode();

      var tokens = DefaultTokens();
      await tester.pumpWidget(materialAppWithTokens(
        tokens: tokens,
        child: ZbjListItem(
          title: 'Test list item',
          focusNode: focusNode, // Pass the FocusNode to the ListItem
          onTap: () {},
        ),
      ));

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      var focusWidget = find.byKey(const Key('outlined_focus'));
      expect(focusWidget, findsOneWidget);

      expect(tester.widget<Material>(focusWidget).shape,
          isA<ZbjDottedBorderShape>());
    });

    testWidgets('Should handle keyboard interaction and call onTap',
        (tester) async {
      // Create a FocusNode that will be passed to the ListItem
      FocusNode focusNode = FocusNode();
      var mockCallback = MockCallback();

      await tester.pumpWidget(materialAppWithTokens(
        child: ZbjListItem(
          title: 'Test list item',
          focusNode: focusNode,
          onTap: mockCallback.call,
        ),
      ));

      // Simulate a user pressing the Tab key to focus the ListItem
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      var focusWidget = find.byKey(const Key('outlined_focus'));

      expect(focusWidget, findsOneWidget);

      expect(tester.widget<Material>(focusWidget).shape,
          isA<ZbjDottedBorderShape>());

      // Simulate a user pressing the Enter key to activate the ListItem
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      // Verify the onTap callback is called
      verify(() => mockCallback()).called(1);
    });

    testWidgets(
      'Screen reader announces correct name when OutlinedFocus is focused',
      (WidgetTester tester) async {
        await tester.pumpWidget(materialAppWithTokens(
          child: ZbjListItem(
            title: 'Test list item',
            onTap: () {},
          ),
        ));

        expect(
          tester.getSemantics(find.byType(InkWell)),
          containsSemantics(
            label: 'Test list item',
            isButton: true,
          ),
        );
      },
    );
  });
}
