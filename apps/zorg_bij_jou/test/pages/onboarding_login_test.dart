import 'package:core/auth/auth_exception.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:zorg_bij_jou/pages/onboarding_login_component.dart';
import 'package:zorg_bij_jou/providers/onboarding_login_component_provider.dart';

import '../helpers.dart';
import 'onboarding_page_test.dart';

Widget materialApp(ProviderContainer container, Widget child) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Tokens(
        tokens: DefaultTokens(),
        child: Localizations(
          delegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          locale: const Locale('nl'),
          child: child,
        ),
      ),
    ),
  );
}

void main() {
  var mockAuth = MockAuth();

  group('OnboardingLoginComponent', () {
    setUp(() async {
      getIt.registerSingleton<Auth>(mockAuth);

      var mockPrinter = MockPrinter();
      getIt.registerSingletonAsync<ZbjLogger>(
          () => ConsoleLogger(printer: mockPrinter.call).initialize(),
          instanceName: 'console');
    });

    tearDown(() async {
      await getIt.reset();
    });

    testWidgets('Renders correctly', (WidgetTester tester) async {
      var container = ProviderContainer();
      container.read(loginViewModelProvider.notifier);

      // Act
      await tester.pumpWidget(materialApp(
        container,
        OnboardingLoginComponent(onContinue: () {}),
      ));

      // pump
      await tester.pumpAndSettle();

      // Verify text on screen
      expect(find.text('We controleren je account'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(7));
    });

    testWidgets('calls onContinue when login', (WidgetTester tester) async {
      bool onContinueCalled = false;

      when(() => mockAuth.login('VALIDO', '01-01-2000'))
          .thenAnswer((_) async => true);

      var container = ProviderContainer();
      container.read(loginViewModelProvider.notifier);

      // Act
      await tester.pumpWidget(materialApp(
        container,
        OnboardingLoginComponent(onContinue: () {
          onContinueCalled = true;
        }),
      ));

      await tester.enterText(find.byType(TextFormField).at(0), 'VALIDO');
      await tester.enterText(find.byType(TextFormField).at(6), '01-01-2000');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(onContinueCalled, isTrue);

      verify(() => mockAuth.login('VALIDO', '01-01-2000')).called(1);
    });

    testWidgets('doesnt call onContinue when login',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 1200);
      tester.view.devicePixelRatio = 1.0;

      bool onContinueCalled = false;

      when(() => mockAuth.login('IVALID', '01-01-2000'))
          .thenThrow(AuthException('fail'));

      var container = ProviderContainer();
      container.read(loginViewModelProvider.notifier);

      // Act
      await tester.pumpWidget(materialApp(
        container,
        MediaQuery(
          data: MediaQueryData(size: tester.view.physicalSize),
          child: OnboardingLoginComponent(onContinue: () {
            onContinueCalled = true;
          }),
        ),
      ));

      await tester.enterText(find.byType(TextFormField).at(0), 'IVALID');
      await tester.enterText(find.byType(TextFormField).at(6), '01-01-2000');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();

      verify(() => mockAuth.login('IVALID', '01-01-2000')).called(1);
      expect(onContinueCalled, isFalse);
    });
  });
}
