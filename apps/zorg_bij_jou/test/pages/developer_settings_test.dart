import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zorg_bij_jou/pages/developer_settings_page.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

import '../helpers.dart';

class _MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late _MockLocalStorage mockLocalStorage;
  late MockGoRouter mockGoRouter;

  setUp(() {
    mockLocalStorage = _MockLocalStorage();
    getIt.registerSingleton<LocalStorage>(mockLocalStorage);
    when(() => mockLocalStorage.loadGridOverlayEnabled())
        .thenAnswer((_) => false);
    when(() => mockLocalStorage.loadLocalAuthEnabled())
        .thenAnswer((_) => false);

    mockGoRouter = MockGoRouter();
    getIt.registerSingleton<GoRouter>(mockGoRouter);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('DeveloperSettingsPage renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: materialAppWithTokens(
          tester: tester,
          child: const DeveloperSettingsPage(),
        ),
      ),
    );

    expect(find.text('Developer Settings'), findsOneWidget);
    expect(find.text('Restart Onboarding'), findsOneWidget);
    expect(find.text('Disable Developer Mode'), findsOneWidget);
  });

  testWidgets('Tapping Restart Onboarding shows confirmation dialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: materialAppWithTokens(
          tester: tester,
          child: const DeveloperSettingsPage(),
        ),
      ),
    );

    await tester.tap(find.text('Restart Onboarding'));
    await tester.pump();

    expect(find.text('Are you sure you want to restart onboarding?'),
        findsOneWidget);
  });

  testWidgets('Tapping Disable Developer Mode shows confirmation dialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: materialAppWithTokens(
          tester: tester,
          child: const DeveloperSettingsPage(),
        ),
      ),
    );

    await tester.tap(find.text('Disable Developer Mode'));
    await tester.pump();

    expect(find.text('Are you sure you want to disable developer mode?'),
        findsOneWidget);
  });

  testWidgets('Confirming Restart Onboarding resets onboarding',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: materialAppWithTokens(
            tester: tester,
            child: const DeveloperSettingsPage(),
          ),
        ),
      ),
    );

    when(() => mockLocalStorage.clearOnboarding())
        .thenAnswer((_) async => Future.value());

    await tester.tap(find.text('Restart Onboarding'));
    await tester.pump();

    await tester.tap(find.text('Confirm').at(1));
    await tester.pump();

    verify(() => mockLocalStorage.clearOnboarding()).called(1);
    verify(() => mockGoRouter.go('/$onboardingRoute')).called(1);
  });

  testWidgets('Confirming Disable Developer Mode disables dev mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: materialAppWithTokens(
            tester: tester,
            child: const DeveloperSettingsPage(),
          ),
        ),
      ),
    );

    when(() => mockLocalStorage.storeDevMode(false))
        .thenAnswer((_) async => Future.value());

    when(() => mockLocalStorage.loadDevMode()).thenAnswer((_) => true);

    await tester.tap(find.text('Disable Developer Mode'));
    await tester.pump();

    await tester.tap(find.text('Confirm').at(1));
    await tester.pump();

    verify(() => mockLocalStorage.storeDevMode(false)).called(1);
  });

  testWidgets('Tapping Enable Grid Overlay enables grid overlay',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: materialAppWithTokens(
          tester: tester,
          child: const DeveloperSettingsPage(),
        ),
      ),
    );

    when(() => mockLocalStorage.storeGridOverlayEnabled(true))
        .thenAnswer((_) async => Future.value());

    await tester.tap(find.text('Enable Grid Overlay'));
    await tester.pump();

    expect(find.text('Disable Grid Overlay'), findsOneWidget);

    verify(() => mockLocalStorage.storeGridOverlayEnabled(true)).called(1);
  });

  testWidgets('Tapping Disable Grid Overlay disables grid overlay',
      (WidgetTester tester) async {
    when(() => mockLocalStorage.loadGridOverlayEnabled())
        .thenAnswer((_) => true);

    await tester.pumpWidget(
      ProviderScope(
        child: materialAppWithTokens(
          tester: tester,
          child: const DeveloperSettingsPage(),
        ),
      ),
    );

    when(() => mockLocalStorage.storeGridOverlayEnabled(false))
        .thenAnswer((_) async => Future.value());

    await tester.tap(find.text('Disable Grid Overlay'));
    await tester.pump();

    verify(() => mockLocalStorage.storeGridOverlayEnabled(false)).called(1);
  });

  testWidgets('Tapping Enable Local Auth enables local auth',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: materialAppWithTokens(
          tester: tester,
          child: const DeveloperSettingsPage(),
        ),
      ),
    );

    when(() => mockLocalStorage.storeLocalAuthEnabled(true))
        .thenAnswer((_) async => Future.value());

    await tester.tap(find.text('Enable Local Auth'));
    await tester.pump();

    expect(find.text('Disable Local Auth'), findsOneWidget);

    verify(() => mockLocalStorage.storeLocalAuthEnabled(true)).called(1);
  });

  testWidgets('Tapping Disable Grid Overlay disables grid overlay',
      (WidgetTester tester) async {
    when(() => mockLocalStorage.loadLocalAuthEnabled()).thenAnswer((_) => true);

    await tester.pumpWidget(
      ProviderScope(
        child: materialAppWithTokens(
          tester: tester,
          child: const DeveloperSettingsPage(),
        ),
      ),
    );

    when(() => mockLocalStorage.storeLocalAuthEnabled(false))
        .thenAnswer((_) async => Future.value());

    await tester.tap(find.text('Disable Local Auth'));
    await tester.pump();

    expect(find.text('Enable Local Auth'), findsOneWidget);

    verify(() => mockLocalStorage.storeLocalAuthEnabled(false)).called(1);
  });
}
