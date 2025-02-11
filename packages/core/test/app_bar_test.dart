import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers.dart';

class MockCallback extends Mock {
  void call();
}

void main() {
  group('App Bar component', () {
    testWidgets('Should have a functioning back button', (tester) async {
      var mockCallback = MockCallback();

      await tester.pumpWidget(materialAppWithTokens(
        child: CustomAppBar(
          onPressed: mockCallback.call,
        ),
      ));

      var backButton = find.byType(Button);

      expect(backButton, findsOneWidget);

      await tester.tap(backButton);

      verify(() => mockCallback()).called(1);
    });
  });
}
