import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  testWidgets('Should format markdown', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: const ZbjMarkdown(
      content: '# Test',
    )));

    var formattedTextFinder = find.text('Test');
    var unformattedTextFinder = find.text('# Test');

    expect(formattedTextFinder, findsOneWidget);
    expect(unformattedTextFinder, isNot(findsAny));
  });

  testWidgets('Should render link text', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: const ZbjMarkdown(
      content: '[link stuff](https://www.example.com)',
    )));

    var linkFinder = find.text('link stuff');
    expect(linkFinder, findsOneWidget);

    await tester.tap(linkFinder);
    await tester.pumpAndSettle();
  });

  testWidgets('Should read link as semantic link', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
        child: const ZbjMarkdown(
      content: '[link stuff](https://www.example.com)',
    )));

    var linkFinder = find.bySemanticsLabel('link stuff');
    expect(linkFinder, findsOneWidget);

    var semantics = tester.getSemantics(linkFinder);
    expect(semantics.hasFlag(SemanticsFlag.isLink), isTrue);
  });
}
