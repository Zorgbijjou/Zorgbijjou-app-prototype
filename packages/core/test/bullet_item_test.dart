import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/theme.dart';

import 'helpers.dart';

void main() {
  testWidgets('Should contain a label', (tester) async {
    await tester.pumpWidget(
        materialAppWithTokens(child: ZbjBulletItem.bullet(label: 'Test')));

    var labelFinder = find.text('Test');

    expect(labelFinder, findsOneWidget);
  });

  testWidgets('Should contain a bullet', (tester) async {
    await tester.pumpWidget(
        materialAppWithTokens(child: ZbjBulletItem.bullet(label: 'Test')));

    var labelFinder = find.text('•');
    await tester.tap(labelFinder);

    expect(labelFinder, findsOneWidget);
  });

  testWidgets('Should render icons', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: ZbjBulletItem.icon(
      label: 'Test',
      icon: const Icon(CustomIcons.arrow_right),
    )));

    var iconFinder = find.byIcon(CustomIcons.arrow_right);

    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Extra should show background color around icon', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: ZbjBulletItem.extra(
      label: 'Test',
      icon: const Icon(CustomIcons.arrow_right),
      iconBackgroundColor: Colors.red,
    )));

    var iconContainerFinder = tester
        .element(find.byIcon(CustomIcons.arrow_right))
        .findAncestorWidgetOfExactType<Container>();

    expect(
        (iconContainerFinder?.decoration as BoxDecoration).color, Colors.red);
  });

  // should render title
  testWidgets('Should render title', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: ZbjBulletItem.extra(
      title: 'Title',
      label: 'Test',
      icon: const Icon(CustomIcons.arrow_right),
      iconBackgroundColor: Colors.red,
    )));

    var labelFinder = find.text('Title');

    expect(labelFinder, findsOneWidget);
  });
}
