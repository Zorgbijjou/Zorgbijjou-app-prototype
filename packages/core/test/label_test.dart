import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  testWidgets('Should contain text and icon', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: const Label(label: 'text', icon: Icons.label)));

    var labelFinder = find.text('text');
    var iconFinder = find.byType(Icon);

    expect(labelFinder, findsOne);
    expect(iconFinder, findsOne);
  });

  testWidgets('Should contain text and no icon', (tester) async {
    await tester
        .pumpWidget(materialAppWithTokens(child: const Label(label: 'text')));

    var labelFinder = find.text('text');
    var iconFinder = find.byType(Icon);

    expect(labelFinder, findsOne);
    expect(iconFinder, findsNothing);
  });
}
