import 'package:core/widgets/grid_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GridOverlay', () {
    testWidgets('should render with correct key for specified width',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 500,
            child: ZbjGridOverlay(),
          ),
        ),
      ));

      expect(find.byKey(const Key('paint_grid_sm')), findsOneWidget);
    });
  });
}
