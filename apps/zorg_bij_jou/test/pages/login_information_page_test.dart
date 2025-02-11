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
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:zorg_bij_jou/pages/login_information_page.dart';
import 'package:zorg_bij_jou/providers/onboarding_page_provider.dart';

import '../helpers.dart';

void main() {
  testWidgets('LoginInformationPage test', (WidgetTester tester) async {
    var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);
    await localeDataSource.initializeLocales([
      'nl',
    ]);
    getIt.registerSingleton<LocaleDataSource>(localeDataSource);

    getIt.registerSingleton<TranslationRepository>(
        TranslationRepositoryImpl(localeDataSource: getIt()));

    var onboardingDataSource = OnboardingDataSourceImpl(bundle: rootBundle);
    getIt.registerSingleton<OnboardingDataSource>(onboardingDataSource);

    var mockLocalStorage = MockLocalStorage();
    getIt.registerSingleton<LocalStorage>(mockLocalStorage);
    when(() => mockLocalStorage.isOnboardingFinished()).thenReturn(false);

    getIt.registerSingleton<Auth>(MockAuth());

    var container = ProviderContainer();
    container.read(onboardingViewModelProvider.notifier);

    // Act
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Tokens(
          tokens: DefaultTokens(),
          child: Localizations(
            locale: const Locale('nl'),
            delegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            child: const LoginInformationPage(),
          ),
        ),
      ),
    );

    // pump
    await tester.pumpAndSettle();

    // Verify text on screen
    expect(find.text('Waar kan ik de code vinden?'), findsOneWidget);
  });
}
