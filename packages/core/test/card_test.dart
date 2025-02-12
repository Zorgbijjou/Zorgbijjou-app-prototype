import 'package:core/core.dart';
import 'package:core/shapes/dotted_border_shape.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/theme.dart';

import 'helpers.dart';

class MockCallback extends Mock {
  void call();
}

void main() {
  group('Card component', () {
    testWidgets('Should display a title, subtitle and body', (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: Card.primary(
          onTap: () {},
          title: 'Test card title',
          subTitle: 'Test card subtitle',
          body: const Text('Test card body'),
          image: const AssetImage('assets/test/image.png'),
        ),
      ));

      var titleFinder = find.text('Test card title');
      var subTitleFinder = find.text('Test card subtitle');
      var bodyFinder = find.text('Test card body');

      expect(titleFinder, findsOneWidget);
      expect(subTitleFinder, findsOneWidget);
      expect(bodyFinder, findsOneWidget);
    });

    testWidgets('Should focus the Card when focus is requested',
        (tester) async {
      var tokens = DefaultTokens();
      await tester.pumpWidget(materialAppWithTokens(
        tokens: tokens,
        child: Card.primary(
          title: 'Test card title',
          onTap: () {},
        ),
      ));

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      var focusWidget = find.byKey(const Key('outlined_focus'));

      expect(focusWidget, findsOneWidget);

      expect(
          tester.widget<Material>(focusWidget).shape, isA<DottedBorderShape>());
    });

    testWidgets('Should handle keyboard interaction and call onTap',
        (tester) async {
      var mockCallback = MockCallback();

      await tester.pumpWidget(materialAppWithTokens(
        child: Card.primary(
          title: 'Test card title',
          onTap: mockCallback.call,
        ),
      ));

      // Simulate a user pressing the Tab key to focus the ListItem
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      var focusWidget = find.byKey(const Key('outlined_focus'));

      expect(focusWidget, findsOneWidget);
      expect(
          tester.widget<Material>(focusWidget).shape, isA<DottedBorderShape>());

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
        child: Card.primary(
          onTap: () {},
          title: 'Test Card',
          body: const Text('Test list item body'),
        ),
      ));

      expect(
        tester.semantics.find(find.byType(Card)),
        containsSemantics(
          label: 'Test Card\nTest list item body',
          isButton: true,
        ),
      );
    });

    testWidgets('Overflowing titles ends in ...', (WidgetTester tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: Card.primary(
          title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Morbi in elit mauris. Nam et facilisis nunc. Nulla augue nisl,'
              ' rutrum eu felis nec, ullamcorper imperdiet purus.',
        ),
      ));

      var textWidget = find.textContaining(RegExp('Lorem ipsum.*?...'));
      expect(textWidget, findsOneWidget);
    });
  });
}
