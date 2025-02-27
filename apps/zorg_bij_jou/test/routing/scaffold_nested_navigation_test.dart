import 'package:core/core.dart';
import 'package:core/widgets/navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zorg_bij_jou/routing/scaffold_nested_navigation.dart';

import '../helpers.dart';

class MockSystemUiModeManager extends Mock implements SystemUiModeManager {}

void main() {
  late MockSystemUiModeManager mockSystemUiModeManager;

  setUp(() {
    mockSystemUiModeManager = MockSystemUiModeManager();
    getIt.registerSingleton<SystemUiModeManager>(mockSystemUiModeManager);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('ScaffoldWithNestedNavigation displays bottom navigation bar',
      (WidgetTester tester) async {
    var mockedWidget = const _MockStatefulWidget();
    var mockNavigationShell = MockStatefulNavigationShell(widget: mockedWidget);

    await tester.pumpWidget(materialAppWithTokens(
      tester: tester,
      child: ScaffoldWithNestedNavigation(
        navigationShell: mockNavigationShell,
        isDevMode: true,
        isGridOverlayEnabled: false,
      ),
    ));

    expect(find.byType(ScaffoldWithNestedNavigation), findsOneWidget);
    expect(find.byType(ZbjNavigationBar), findsOneWidget);
  });

  testWidgets(
      'ScaffoldWithNestedNavigation with grid overlay displays grid overlay',
      (WidgetTester tester) async {
    var mockedWidget = const _MockStatefulWidget();
    var mockNavigationShell = MockStatefulNavigationShell(widget: mockedWidget);

    await tester.pumpWidget(materialAppWithTokens(
      tester: tester,
      child: ScaffoldWithNestedNavigation(
        navigationShell: mockNavigationShell,
        isDevMode: true,
        isGridOverlayEnabled: true,
      ),
    ));

    expect(find.byType(ScaffoldWithNestedNavigation), findsOneWidget);
    expect(find.byType(ZbjGridOverlay), findsOneWidget);
  });

  testWidgets(
      'ScaffoldWithNestedNavigation without grid overlay does not display grid overlay',
      (WidgetTester tester) async {
    var mockedWidget = const _MockStatefulWidget();
    var mockNavigationShell = MockStatefulNavigationShell(widget: mockedWidget);

    await tester.pumpWidget(materialAppWithTokens(
      tester: tester,
      child: ScaffoldWithNestedNavigation(
        navigationShell: mockNavigationShell,
        isDevMode: false,
        isGridOverlayEnabled: true,
      ),
    ));

    expect(find.byType(ScaffoldWithNestedNavigation), findsOneWidget);
    expect(find.byType(ZbjGridOverlay), findsNothing);
  });

  testWidgets(
      'ScaffoldWithNestedNavigation renders widget thats in the navigation shell',
      (WidgetTester tester) async {
    var mockedWidget = const _MockStatefulWidget();
    var mockNavigationShell = MockStatefulNavigationShell(widget: mockedWidget);

    await tester.pumpWidget(materialAppWithTokens(
      tester: tester,
      child: ScaffoldWithNestedNavigation(
        navigationShell: mockNavigationShell,
        isDevMode: false,
        isGridOverlayEnabled: false,
      ),
    ));

    expect(find.byType(ScaffoldWithNestedNavigation), findsOneWidget);
    expect(find.byType(_MockStatefulWidget), findsOneWidget);
  });

  testWidgets(
      'ScaffoldWithNestedNavigation calls goBranch when destination is selected',
      (WidgetTester tester) async {
    var mockedWidget = const _MockStatefulWidget();
    var mockNavigationShell = MockStatefulNavigationShell(widget: mockedWidget);

    await tester.pumpWidget(materialAppWithTokens(
      tester: tester,
      child: ScaffoldWithNestedNavigation(
        navigationShell: mockNavigationShell,
        isDevMode: true,
        isGridOverlayEnabled: false,
      ),
    ));

    // pump settle
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ZbjNavigationBarItemWidget).first);
    verify(() => mockNavigationShell.goBranch(0, initialLocation: true))
        .called(1);
  });

  testWidgets(
      'ScaffoldWithNestedNavigation calls goBranch when last destination is selected',
      (WidgetTester tester) async {
    var mockedWidget = const _MockStatefulWidget();
    var mockNavigationShell = MockStatefulNavigationShell(widget: mockedWidget);

    await tester.pumpWidget(materialAppWithTokens(
      tester: tester,
      child: ScaffoldWithNestedNavigation(
        navigationShell: mockNavigationShell,
        isDevMode: true,
        isGridOverlayEnabled: false,
      ),
    ));

    // pump settle
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ZbjNavigationBarItemWidget).at(1));
    verify(() => mockNavigationShell.goBranch(1, initialLocation: false))
        .called(1);
  });

  // test for the _updateSystemUIOverlay method
  testWidgets(
      'ScaffoldWithNestedNavigation calls updateSystemUIOverlay to show status bar for non landscape device',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(600, 1000);

    var mockedWidget = const _MockStatefulWidget();
    var mockNavigationShell = MockStatefulNavigationShell(widget: mockedWidget);

    await tester.pumpWidget(materialAppWithTokens(
      tester: tester,
      child: ScaffoldWithNestedNavigation(
        navigationShell: mockNavigationShell,
        isDevMode: true,
        isGridOverlayEnabled: false,
      ),
    ));

    // pump settle
    await tester.pumpAndSettle();

    verify(() => mockSystemUiModeManager.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values)).called(1);
  });

  // now for the landscape device
  testWidgets(
      'ScaffoldWithNestedNavigation calls updateSystemUIOverlay to hide status bar for mobile device in landscape',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(600, 400);
    tester.view.devicePixelRatio = 1.0;

    var mockedWidget = const _MockStatefulWidget();
    var mockNavigationShell = MockStatefulNavigationShell(widget: mockedWidget);

    await tester.pumpWidget(materialAppWithTokens(
      tester: tester,
      child: ScaffoldWithNestedNavigation(
        navigationShell: mockNavigationShell,
        isDevMode: true,
        isGridOverlayEnabled: false,
      ),
    ));

    // pump settle
    await tester.pumpAndSettle();

    verify(() => mockSystemUiModeManager.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]));
  });
}

class _MockStatefulWidget extends StatefulWidget {
  const _MockStatefulWidget();

  @override
  State<_MockStatefulWidget> createState() => _MockStatefulWidgetState();
}

class _MockStatefulWidgetState extends State<_MockStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
