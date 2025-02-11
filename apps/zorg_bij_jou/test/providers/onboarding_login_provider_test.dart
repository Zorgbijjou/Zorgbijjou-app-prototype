import 'package:core/auth/auth_exception.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/view_models/login_view_model.dart';
import 'package:zorg_bij_jou/providers/onboarding_login_component_provider.dart';

import '../helpers.dart';
import '../pages/onboarding_page_test.dart';

void main() {
  group('LoginViewModelStateNotifier', () {
    var mockAuth = MockAuth();

    setUp(() {
      getIt.registerSingleton<Auth>(mockAuth);

      var mockPrinter = MockPrinter();
      getIt.registerSingletonAsync<ZbjLogger>(
          () => ConsoleLogger(printer: mockPrinter.call).initialize(),
          instanceName: 'console');
    });

    tearDown(() {
      getIt.reset();
    });

    testWidgets('Test LoginViewModelStateNotifier',
        (WidgetTester tester) async {
      var container = ProviderContainer();

      // Act
      var viewModel = container.read(loginViewModelProvider);

      // Assert
      expect(viewModel.error, isNull);

      // Workaround to keep auto disposed view model alive
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('onSubmitLogin success', (WidgetTester tester) async {
      var container = ProviderContainer();

      when(() => mockAuth.login('validCode', 'validDate'))
          .thenAnswer((_) async {});

      var notifier = container.read(loginViewModelProvider.notifier);

      await tester.pumpWidget(Form(key: notifier.formKey, child: Container()));

      notifier.loginCodeController.text = 'validCode';
      notifier.birthDateController.text = 'validDate';

      bool result = await notifier.onSubmitLogin();

      expect(result, isTrue);
      expect(notifier.state.error, isNull);

      await tester.pumpAndSettle();
    });

    testWidgets('onSubmitLogin authentication error',
        (WidgetTester tester) async {
      var container = ProviderContainer();
      when(() => mockAuth.login('invalidCode', 'invalidDate'))
          .thenThrow(AuthException('Invalid credentials'));

      var notifier = container.read(loginViewModelProvider.notifier);
      await tester.pumpWidget(Form(key: notifier.formKey, child: Container()));

      notifier.loginCodeController.text = 'invalidCode';
      notifier.birthDateController.text = 'invalidDate';

      bool result = await notifier.onSubmitLogin();

      expect(result, isFalse);
      expect(notifier.state.error, LoginError.authenticationError);

      await tester.pumpAndSettle();
    });

    testWidgets('onSubmitLogin unexpected error', (WidgetTester tester) async {
      var container = ProviderContainer();
      when(() => mockAuth.login('code', 'date'))
          .thenThrow(Exception('Unexpected error'));

      var notifier = container.read(loginViewModelProvider.notifier);
      await tester.pumpWidget(Form(key: notifier.formKey, child: Container()));

      notifier.loginCodeController.text = 'code';
      notifier.birthDateController.text = 'date';

      bool result = await notifier.onSubmitLogin();

      expect(result, isFalse);
      expect(notifier.state.error, LoginError.unexpectedError);

      await tester.pumpAndSettle();
    });
  });

  group('LoginViewModelStateNotifier validation', () {
    var mockAuth = MockAuth();

    setUp(() {
      getIt.registerSingleton<Auth>(mockAuth);

      var mockPrinter = MockPrinter();
      getIt.registerSingletonAsync<ZbjLogger>(
          () => ConsoleLogger(printer: mockPrinter.call).initialize(),
          instanceName: 'console');
    });

    tearDown(() {
      getIt.reset();
    });

    testWidgets('onSubmitLogin validations failed',
        (WidgetTester tester) async {
      var container = ProviderContainer();

      var notifier = container.read(loginViewModelProvider.notifier);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Form(
            key: notifier.formKey,
            child: TextFormField(
              controller: notifier.loginCodeController,
              validator: (value) {
                return 'error';
              },
            ),
          ),
        ),
      ));

      notifier.loginCodeController.text = 'something';
      notifier.birthDateController.text = 'else';

      bool result = await notifier.onSubmitLogin();

      expect(result, isFalse);

      await tester.pumpAndSettle();

      verifyZeroInteractions(mockAuth);
    });
  });
}
