import 'package:chat/data_source/chat_data_source.dart';
import 'package:chat/data_source/chat_data_source_impl.dart';
import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:faq/faq.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:onboarding/data_source/onboarding_data_source.dart';
import 'package:onboarding/data_source/onboarding_data_source_impl.dart';
import 'package:uuid/uuid.dart';

Future<void> setupLocator() async {
  getIt.registerSingleton(
      const String.fromEnvironment(APP_INSIGHTS_INSTRUMENTATION_KEY),
      instanceName: APP_INSIGHTS_INSTRUMENTATION_KEY);
  getIt.registerSingleton(const Uuid().v4(),
      instanceName: APP_INSIGHTS_SESSION_ID);

  getIt.registerSingletonAsync<ZbjLogger>(() async {
    LocalStorage localStorage = await getIt.getAsync();
    return ConsoleLogger(userCode: localStorage.getCode() ?? '').initialize();
  }, instanceName: 'console');

  getIt.registerSingletonAsync<ZbjLogger>(() async {
    LocalStorage localStorage = await getIt.getAsync();
    AppInsightsLogger insightsLogger = AppInsightsLogger(
      instrumentationKey:
          getIt<String>(instanceName: APP_INSIGHTS_INSTRUMENTATION_KEY),
      sessionId: getIt<String>(instanceName: APP_INSIGHTS_SESSION_ID),
      userCode: localStorage.getCode() ?? '',
    );
    return insightsLogger.initialize();
  }, instanceName: 'app-insights');

  getIt.registerSingletonAsync<LocaleDataSource>(() async {
    var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);
    await localeDataSource.initializeLocales([
      'nl',
      'en',
    ]);
    return localeDataSource;
  });

  getIt.registerSingleton<TocDataSource>(TocDataSourceImpl(bundle: rootBundle));

  getIt.registerSingleton<OnboardingDataSource>(
      OnboardingDataSourceImpl(bundle: rootBundle));

  getIt.registerSingletonAsync<LocalStorage>(() async {
    LocalStorage localStorage = LocalStorage();
    await localStorage.initialize();
    return localStorage;
  });

  getIt.registerSingleton<SubjectRepository>(
      SubjectRepositoryImpl(tocDataSource: getIt()));
  getIt.registerSingleton<QuestionRepository>(
      QuestionRepositoryImpl(tocDataSource: getIt()));
  getIt.registerSingleton<TranslationRepository>(
      TranslationRepositoryImpl(localeDataSource: await getIt.getAsync()));

  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<Auth>(AuthImpl(storage: getIt()));
  getIt.registerSingleton<LocalAuthentication>(LocalAuthentication());
  getIt.registerSingleton<LocalAuth>(LocalAuthImpl(localAuth: getIt()));

  getIt.registerSingleton<ChatDataSource>(
    ChatDataSourceImpl(
      client: http.Client(),
      auth: getIt(),
    ),
  );

  getIt.registerSingleton<SystemUiModeManager>(SystemUiModeManagerImpl());

  await getIt.allReady();
}
