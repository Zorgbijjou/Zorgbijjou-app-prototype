import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zorg_bij_jou/pages/not_found_page.dart';

void main() {
  group('NotFound Page', () {
    testWidgets('should render', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: NotFoundPage(uri: 'test'),
        ),
      );

      // Verify text on screen
      expect(find.text('404 - Page not found with uri: test'), findsOneWidget);
    });
  });
}
