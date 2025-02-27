import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

import 'helpers.dart';

void main() {
  group('Divider', () {
    testWidgets('Should render a divider', (tester) async {
      await tester
          .pumpWidget(materialAppWithTokens(child: ZbjDivider.standard()));

      var dividerFinder = find.byType(Divider);

      expect(dividerFinder, findsOne);

      Divider divider = tester.widget<Divider>(dividerFinder);
      expect(divider.color,
          equals(DefaultTokens().color.tokensWhite.withValues(alpha: 0.32)));
    });

    testWidgets('Should render an inverted divider', (tester) async {
      await tester
          .pumpWidget(materialAppWithTokens(child: ZbjDivider.inverted()));

      var dividerFinder = find.byType(Divider);

      expect(dividerFinder, findsOne);

      Divider divider = tester.widget<Divider>(dividerFinder);
      expect(divider.color,
          equals(DefaultTokens().color.tokensGrey800.withValues(alpha: 0.32)));
    });

    testWidgets('Should render a label and divider on each side',
        (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
          child: ZbjDivider.label(label: 'Text', color: Colors.red)));

      expect(find.byType(Divider), findsExactly(2));
      expect(find.text('Text'), findsOneWidget);
    });
  });
}
