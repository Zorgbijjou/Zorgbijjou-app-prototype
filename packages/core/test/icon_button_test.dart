import 'package:core/shapes/dotted_border_shape.dart';
import 'package:core/widgets/icon_button.dart';
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
  testWidgets('Should contain an icon', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: ZbjIconButton.primary(
      icon: const Icon(Icons.add),
      onPressed: () {},
    )));

    var iconFinder = find.byIcon(Icons.add);

    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Should register clicks', (tester) async {
    var clicked = false;

    await tester.pumpWidget(materialAppWithTokens(
        child: ZbjIconButton.brand(
      icon: const Icon(Icons.add),
      onPressed: () {
        clicked = true;
      },
    )));

    var iconFinder = find.byIcon(Icons.add);
    await tester.tap(iconFinder);

    expect(clicked, true);
  });

  testWidgets('Should focus the ZbjIconButton when focusNode is requested',
      (tester) async {
    var tokens = DefaultTokens();
    await tester.pumpWidget(materialAppWithTokens(
      tokens: tokens,
      child: ZbjIconButton.primary(
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    ));

    // Simulate a user pressing the Tab key to focus the ListItem
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();

    var focusWidget = find.byKey(const Key('outlined_focus'));

    expect(focusWidget, findsOneWidget);

    expect(tester.widget<Material>(focusWidget).shape,
        isA<ZbjDottedBorderShape>());
  });

  testWidgets('Should handle keyboard interaction and call onTap',
      (tester) async {
    var mockCallback = MockCallback();

    await tester.pumpWidget(materialAppWithTokens(
      child: ZbjIconButton.primary(
        icon: const Icon(Icons.add),
        onPressed: mockCallback.call,
      ),
    ));

    // Simulate a user pressing the Tab key to focus the ListItem
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();

    var focusWidget = find.byKey(const Key('outlined_focus'));

    expect(focusWidget, findsOneWidget);
    expect(tester.widget<Material>(focusWidget).shape,
        isA<ZbjDottedBorderShape>());

    // Simulate a user pressing the Enter key to call the onTap function
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();

    // Verify the onTap function was called
    verify(() => mockCallback()).called(1);
  });

  testWidgets(
      'Screen reader announces correct name when OutlinedFocus is focused',
      (WidgetTester tester) async {
    await tester.pumpWidget(materialAppWithTokens(
      child: ZbjIconButton.primary(
        icon: const Icon(Icons.add),
        onPressed: () {},
        tooltip: 'Add',
      ),
    ));

    expect(
      tester.semantics.find(find.byType(IconButton)),
      containsSemantics(tooltip: 'Add'),
    );
  });
}
