import 'package:core/widgets/icon_with_dev_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers.dart';

class MockCallbacks extends Mock {
  void onDevModeEnabled();
  void onDevButtonClick();
}

void main() {
  late MockCallbacks mockCallbacks;

  setUp(() {
    mockCallbacks = MockCallbacks();
  });

  testWidgets('IconWithDevModeButton initial state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      materialAppWithTokens(
        child: ZbjIconWithDevModeButton(
          icon: const Icon(Icons.settings),
          devModeEnabled: false,
          onDevModeEnabled: mockCallbacks.onDevModeEnabled,
          onDevButtonClick: mockCallbacks.onDevButtonClick,
        ),
      ),
    );

    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.text('DEV'), findsNothing);
  });

  testWidgets('IconWithDevModeButton enables dev mode after 5 clicks',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      materialAppWithTokens(
        child: ZbjIconWithDevModeButton(
          icon: const Icon(Icons.settings),
          devModeEnabled: false,
          onDevModeEnabled: mockCallbacks.onDevModeEnabled,
          onDevButtonClick: mockCallbacks.onDevButtonClick,
        ),
      ),
    );

    var iconFinder = find.byIcon(Icons.settings);

    for (int i = 0; i < 5; i++) {
      await tester.tap(iconFinder);
      await tester.pump(const Duration(milliseconds: 500));
    }

    verify(() => mockCallbacks.onDevModeEnabled()).called(1);
  });

  testWidgets('IconWithDevModeButton shows DEV button when dev mode is enabled',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      materialAppWithTokens(
        child: ZbjIconWithDevModeButton(
          icon: const Icon(Icons.settings),
          devModeEnabled: true,
          onDevModeEnabled: mockCallbacks.onDevModeEnabled,
          onDevButtonClick: mockCallbacks.onDevButtonClick,
        ),
      ),
    );

    expect(find.text('DEV'), findsOneWidget);
  });

  testWidgets('IconWithDevModeButton DEV button triggers callback',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      materialAppWithTokens(
        child: ZbjIconWithDevModeButton(
          icon: const Icon(Icons.settings),
          devModeEnabled: true,
          onDevModeEnabled: mockCallbacks.onDevModeEnabled,
          onDevButtonClick: mockCallbacks.onDevButtonClick,
        ),
      ),
    );

    await tester.tap(find.text('DEV'));
    await tester.pump();

    verify(() => mockCallbacks.onDevButtonClick()).called(1);
  });
}
