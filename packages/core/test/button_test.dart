import 'package:core/shapes/dotted_border_shape.dart';
import 'package:core/widgets/button.dart';
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
        child: Button.primary(
      label: 'Test',
      onPressed: () {},
    )));

    var labelFinder = find.text('Test');

    expect(labelFinder, findsOneWidget);
  });

  testWidgets('Should register clicks', (tester) async {
    var clicked = false;

    await tester.pumpWidget(materialAppWithTokens(
        child: Button.brand(
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
        child: Button.secondary(
      label: 'Test',
      icon: const Icon(CustomIcons.arrow_right),
      iconAlignment: IconAlignment.start,
      onPressed: () {},
    )));

    var iconFinder = find.byIcon(CustomIcons.arrow_right);

    expect(iconFinder, findsOneWidget);

    var labelFinder = find.text('Test');
    var iconCenter = tester.getCenter(iconFinder);
    var labelCenter = tester.getCenter(labelFinder);

    expect(iconCenter.dx, lessThan(labelCenter.dx));

    await tester.pumpWidget(materialAppWithTokens(
        child: Button.subtle(
      label: 'Test',
      icon: const Icon(CustomIcons.arrow_right),
      iconAlignment: IconAlignment.end,
      onPressed: () {},
    )));

    iconCenter = tester.getCenter(iconFinder);
    labelCenter = tester.getCenter(labelFinder);

    expect(iconCenter.dx, greaterThan(labelCenter.dx));
  });

  testWidgets('Should focus the Button when focusNode is requested',
      (tester) async {
    var tokens = DefaultTokens();
    await tester.pumpWidget(materialAppWithTokens(
      tokens: tokens,
      child: Button.primary(
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
      child: Button.primary(
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

  testWidgets(
      'Screen reader announces correct name when OutlinedFocus is focused',
      (WidgetTester tester) async {
    await tester.pumpWidget(materialAppWithTokens(
      child: Button.primary(
        label: 'Test',
        onPressed: () {},
      ),
    ));

    expect(
      tester.semantics.find(find.byType(FilledButton)),
      containsSemantics(label: 'Test'),
    );
  });
}
