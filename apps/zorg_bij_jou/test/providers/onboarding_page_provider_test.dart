import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/data_source/onboarding_data_source.dart';
import 'package:onboarding/mocks/mock_data_source.dart';
import 'package:zorg_bij_jou/providers/onboarding_page_provider.dart';

import '../helpers.dart';

void main() {
  group('OnboardingViewModelStateNotifier', () {
    var onboardingDataSource = MockOnboardingDataSource();

    setUp(() {
      getIt.registerSingleton<OnboardingDataSource>(onboardingDataSource);

      var mockLocalStorage = MockLocalStorage();
      getIt.registerSingleton<LocalStorage>(mockLocalStorage);
      when(() => mockLocalStorage.isOnboardingFinished()).thenReturn(false);

      getIt.registerSingleton<Auth>(MockAuth());
    });

    tearDown(() {
      getIt.reset();
    });

    testWidgets('Test OnboardingViewModelStateNotifier',
        (WidgetTester tester) async {
      var container = ProviderContainer();

      OnboardingViewModelStateNotifier viewModelNotifier =
          container.read(onboardingViewModelProvider.notifier);

      // Act
      await viewModelNotifier.initializeWithContent();

      var viewModel = container.read(onboardingViewModelProvider);

      // Assert
      expect(viewModel.termsAndConditionsContent,
          equals(mockTermsAndConditionsContent['nl']));
      expect(viewModel.loginInformationContent,
          equals(mockLoginInformationContent['nl']));

      // Workaround to keep auto disposed view model alive
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
