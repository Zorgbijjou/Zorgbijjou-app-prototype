import 'package:core/shapes/dotted_border_shape.dart';
import 'package:core/widgets/stacked_button.dart';
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
  testWidgets('Should contain a label', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: StackedButton.primary(
      label: 'Test',
      onPressed: () {},
    )));

    var labelFinder = find.text('Test');

    expect(labelFinder, findsOneWidget);
  });

  testWidgets('Should register clicks', (tester) async {
    var clicked = false;

    await tester.pumpWidget(materialAppWithTokens(
        child: StackedButton.primary(
      label: 'Test',
      onPressed: () {
        clicked = true;
      },
    )));

    var labelFinder = find.text('Test');
    await tester.tap(labelFinder);

    expect(clicked, true);
  });

  testWidgets('Should render icons', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: StackedButton.primary(
      label: 'Test',
      icon: const Icon(CustomIcons.arrow_right),
      onPressed: () {},
    )));

    var iconFinder = find.byIcon(CustomIcons.arrow_right);

    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Should focus the StackedButton when focusNode is requested',
      (tester) async {
    var tokens = DefaultTokens();
    await tester.pumpWidget(materialAppWithTokens(
      tokens: tokens,
      child: StackedButton.primary(
        label: 'Test',
        onPressed: () {},
      ),
    ));

    // Simulate a user pressing the Tab key to focus the ListItem
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
      child: StackedButton.primary(
        label: 'Test',
        onPressed: mockCallback.call,
      ),
    ));

    // Simulate a user pressing the Tab key to focus the ListItem
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();

    var focusWidget = find.byKey(const Key('outlined_focus'));

    expect(focusWidget, findsOneWidget);
    expect(
        tester.widget<Material>(focusWidget).shape, isA<DottedBorderShape>());

    // Simulate a user pressing the Enter key to call the onTap function
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();

    // Verify the onTap function was called
    verify(() => mockCallback()).called(1);
  });
}
