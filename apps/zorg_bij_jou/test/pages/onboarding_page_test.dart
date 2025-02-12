import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/data_source/onboarding_data_source.dart';
import 'package:onboarding/data_source/onboarding_data_source_impl.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:zorg_bij_jou/pages/onboarding_page.dart';
import 'package:zorg_bij_jou/providers/onboarding_page_provider.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

import '../helpers.dart';

class MockUpdateFunction extends Mock {
  Future<void> call(String code);
}

class MockPrinter extends Mock {
  void call(Object? params);
}

void main() {
  var mockLocalStorage = MockLocalStorage();
  var mockAuth = MockAuth();

  group('Onboarding', () {
    setUp(() async {
      var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);
      await localeDataSource.initializeLocales([
        'nl',
      ]);

      getIt.registerSingleton<LocaleDataSource>(localeDataSource);
      getIt.registerSingleton<TranslationRepository>(
          TranslationRepositoryImpl(localeDataSource: getIt()));

      getIt.registerSingleton<Auth>(mockAuth);

      var onboardingDataSource = OnboardingDataSourceImpl(bundle: rootBundle);
      getIt.registerSingleton<OnboardingDataSource>(onboardingDataSource);

      when(() => mockLocalStorage.isOnboardingFinished()).thenReturn(false);
      getIt.registerSingleton<LocalStorage>(mockLocalStorage);

      var mockPrinter = MockPrinter();
      getIt.registerSingletonAsync<ZbjLogger>(
          () => ConsoleLogger(printer: mockPrinter.call).initialize(),
          instanceName: 'console');
    });

    tearDown(() async {
      reset(mockLocalStorage);
      reset(mockLocalStorage);
      await getIt.reset();
    });

    testWidgets('Onboarding page test', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      var container = ProviderContainer();
      container.read(onboardingViewModelProvider.notifier);

      // Act
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: materialAppWithTokens(
            tester: tester,
            tokens: DefaultTokens(),
            child: Localizations(
              delegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              locale: const Locale('nl'),
              child: const OnboardingPage(),
            ),
          ),
        ),
      );

      // pump
      await tester.pumpAndSettle();

      // Verify text on screen
      expect(find.text('We hebben je toestemming nodig'), findsOneWidget);
      expect(
          find.text(
              'Je gegevens zijn te zien voor de verpleegkundigen en je behandelaar.'),
          findsOneWidget);
    });

    testWidgets('Should go to code page when accepting terms',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      var container = ProviderContainer();

      // Act
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: materialAppWithTokens(
            tester: tester,
            tokens: DefaultTokens(),
            child: Localizations(
              delegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              locale: const Locale('nl'),
              child: const OnboardingPage(),
            ),
          ),
        ),
      );

      // pump
      await tester.pumpAndSettle();

      // Verify text on screen
      expect(find.text('We hebben je toestemming nodig'), findsOneWidget);

      await tester.tap(find.text('Ik ga akkoord'));
      await tester.pumpAndSettle();

      // Verify that we are on the code page
      expect(find.text('Vul de code in'), findsOneWidget);
    });

    testWidgets('Should show error when submitting invalid code',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      var container = ProviderContainer();
      container.read(onboardingViewModelProvider.notifier);

      // Act
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: materialAppWithTokens(
            tester: tester,
            tokens: DefaultTokens(),
            child: Localizations(
              delegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              locale: const Locale('nl'),
              child: const OnboardingPage(),
            ),
          ),
        ),
      );

      // pump
      await tester.pumpAndSettle();

      // Verify text on screen
      expect(find.text('We hebben je toestemming nodig'), findsOneWidget);

      await tester.tap(find.text('Ik ga akkoord'));
      await tester.pumpAndSettle();

      // Verify that we are on the code page
      expect(find.text('Vul de code in'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).at(0), 'A');
      await tester.enterText(find.byType(TextFormField).at(1), 'B');
      await tester.pumpAndSettle();

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      // Verify that we are on the code page
      expect(find.text('Vul alsjeblieft je code in.'), findsOneWidget);
    });

    testWidgets(
        'Should go to next page and show patient information when submitting valid code',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(450, 800);
      tester.view.devicePixelRatio = 1.0;

      var container = ProviderContainer();
      container.read(onboardingViewModelProvider.notifier);

      when(() => mockAuth.login('ZBJFTX', '01-11-2020'))
          .thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: materialAppWithTokens(
            tester: tester,
            tokens: DefaultTokens(),
            child: Localizations(
              delegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              locale: const Locale('nl'),
              child: const OnboardingPage(),
            ),
          ),
        ),
      );

      // pump
      await tester.pumpAndSettle();

      // Verify text on screen
      expect(find.text('We hebben je toestemming nodig'), findsOneWidget);

      await tester.tap(find.text('Ik ga akkoord'));
      await tester.pumpAndSettle();

      // Verify that we are on the code page
      expect(find.text('Vul de code in'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).at(0), 'ZBJFTX');
      await tester.enterText(find.byType(TextFormField).at(6), '01-11-2020');
      await tester.pumpAndSettle();

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify that we are on the correct page
      expect(find.text('We herkennen de volgende gegevens:'), findsOneWidget);

      expect(
          find.text(
              'Je ziekenhuis is het Martini Ziekenhuis en bent onder behandeling bij Gynaecologie'),
          findsOneWidget);
      expect(find.text('Je krijgt zorg voor Zwangerschapsdiabetes'),
          findsOneWidget);
      expect(find.text('Je naam is Jeroen Drouwen'), findsOneWidget);
    });

    testWidgets('Onboarding navigate to Terms and Conditions page',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      var mockGoRouter = MockGoRouter();

      var container = ProviderContainer();
      container.read(onboardingViewModelProvider.notifier);

      // Act
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: materialAppWithTokens(
              tester: tester,
              tokens: DefaultTokens(),
              child: Localizations(
                delegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                locale: const Locale('nl'),
                child: const OnboardingPage(),
              ),
            ),
          ),
        ),
      );

      // pump
      await tester.pumpAndSettle();

      // navigate to page
      await tester.ensureVisible(find.text('Lees alle voorwaarden'));
      await tester.tap(find.text('Lees alle voorwaarden'));
      await tester.pumpAndSettle();

      verify(() =>
              mockGoRouter.go('/$onboardingRoute/$termsAndConditionsRoute'))
          .called(1);
    });

    testWidgets('Onboarding navigate to Login Information page',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      var mockGoRouter = MockGoRouter();

      var container = ProviderContainer();
      container.read(onboardingViewModelProvider.notifier);

      // Act
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: materialAppWithTokens(
              tester: tester,
              tokens: DefaultTokens(),
              child: Localizations(
                delegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                locale: const Locale('nl'),
                child: const OnboardingPage(),
              ),
            ),
          ),
        ),
      );

      // pump
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ik ga akkoord'));
      await tester.pumpAndSettle();

      // navigate to page
      await tester.ensureVisible(find.text('Waar kan ik de code vinden?'));
      await tester.tap(find.text('Waar kan ik de code vinden?'));
      await tester.pumpAndSettle();

      verify(() => mockGoRouter.go('/$onboardingRoute/$loginInformationRoute'))
          .called(1);
    });

    testWidgets('Onboarding finish onboarding', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(450, 800);
      tester.view.devicePixelRatio = 1.0;

      var mockGoRouter = MockGoRouter();

      var container = ProviderContainer();
      container.read(onboardingViewModelProvider.notifier);

      when(() => mockAuth.login('ZBJFTW', '01-11-2020'))
          .thenAnswer((_) async {});
      when(() => mockLocalStorage.storeFinishedOnboarding())
          .thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: materialAppWithTokens(
              tester: tester,
              tokens: DefaultTokens(),
              child: Localizations(
                delegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                locale: const Locale('nl'),
                child: const OnboardingPage(),
              ),
            ),
          ),
        ),
      );

      // pump
      await tester.pumpAndSettle();

      // navigate to page
      await tester.tap(find.text('Ik ga akkoord'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'ZBJFTW');
      await tester.enterText(find.byType(TextFormField).at(6), '01-11-2020');
      await tester.pumpAndSettle();

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester
          .ensureVisible(find.text('We herkennen de volgende gegevens:'));

      await tester.tap(find.text('Gegevens kloppen'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(
          find.text('Welkom! Samen houden we jouw gezondheid in de gaten'));

      await tester.tap(find.byIcon(CustomIcons.arrow_right));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Zorg bij jou'));

      await tester.tap(find.byIcon(CustomIcons.arrow_right));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Thuismeten'));

      await tester.tap(find.byIcon(CustomIcons.arrow_right));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Begrepen'));
      await tester.pumpAndSettle();

      // Verify we finish the onboarding
      verify(() => mockLocalStorage.storeFinishedOnboarding()).called(1);
      verify(() => mockAuth.login('ZBJFTW', '01-11-2020')).called(1);
      verify(() => mockGoRouter.go('/$supportHome')).called(1);
    });
  });
}
