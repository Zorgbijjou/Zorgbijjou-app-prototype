import 'dart:async';

import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:core/mocks/mock_logger.dart';
import 'package:core/mocks/mock_translation_repository.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:faq/repository/subject_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/data_source/onboarding_data_source.dart';
import 'package:onboarding/mocks/mock_data_source.dart';
import 'package:zorg_bij_jou/pages/conversations_page.dart';
import 'package:zorg_bij_jou/pages/developer_settings_page.dart';
import 'package:zorg_bij_jou/pages/home_page.dart';
import 'package:zorg_bij_jou/pages/login_information_page.dart';
import 'package:zorg_bij_jou/pages/not_found_page.dart';
import 'package:zorg_bij_jou/pages/onboarding_page.dart';
import 'package:zorg_bij_jou/pages/support_question_page.dart';
import 'package:zorg_bij_jou/pages/support_subject_page.dart';
import 'package:zorg_bij_jou/pages/terms_and_conditions_page.dart';
import 'package:zorg_bij_jou/providers/conversation_page_provider.dart';
import 'package:zorg_bij_jou/providers/conversations_provider.dart';
import 'package:zorg_bij_jou/providers/time_providers.dart';
import 'package:zorg_bij_jou/routing/router.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

import '../helpers.dart';

void main() {
  late MockAuth mockAuth;
  late MockLocalAuth mockLocalAuth;
  late MockLocalStorage mockLocalStorage;
  late MockChatDataSource mockChatDataSource;
  late MockTimer mockTimer;

  setUp(() {
    mockAuth = MockAuth();
    when(() => mockAuth.hasRefreshToken())
        .thenAnswer((_) => Future.value(true));
    getIt.registerSingleton<Auth>(mockAuth);

    mockLocalAuth = MockLocalAuth();
    when(() => mockLocalAuth.isLocallyAuthenticated(
          challengeReason: any(named: 'challengeReason'),
          cancelButton: any(named: 'cancelButton'),
        )).thenAnswer((_) => Future.value(true));
    getIt.registerSingleton<LocalAuth>(mockLocalAuth);

    mockLocalStorage = MockLocalStorage();
    getIt.registerSingleton<LocalStorage>(mockLocalStorage);
    getIt.registerSingleton<SystemUiModeManager>(SystemUiModeManagerImpl());
    when(() => mockLocalStorage.isOnboardingFinished()).thenReturn(false);
    when(() => mockLocalStorage.getCode()).thenReturn('123');
    when(() => mockLocalStorage.loadGridOverlayEnabled()).thenReturn(true);
    when(() => mockLocalStorage.loadLocalAuthEnabled()).thenReturn(false);

    getIt.registerSingleton<OnboardingDataSource>(MockOnboardingDataSource());
    getIt.registerSingleton<TranslationRepository>(MockTranslationRepository());
    getIt.registerSingleton<ZbjLogger>(MockLogger());
    getIt.registerSingleton<QuestionRepository>(MockQuestionRepository());
    getIt.registerSingleton<SubjectRepository>(MockSubjectRepository());

    mockChatDataSource = MockChatDataSource();
    when(() => mockChatDataSource.fetchConversations())
        .thenAnswer((_) => Future.value(mockConversations['123']));
    getIt.registerSingleton<ChatDataSource>(mockChatDataSource);

    mockTimer = MockTimer.periodic(const Duration(minutes: 1), (timer) {});
    getIt.registerFactory<Timer>(() => mockTimer);
  });

  tearDown(() {
    getIt.reset();
  });

  Future<ProviderContainer> setupWidget(
      WidgetTester tester, GoRouter router) async {
    var container = ProviderContainer(
      overrides: [
        timerFactoryProvider
            .overrideWithValue((duration, callback) => mockTimer),
        conversationsStateProvider.overrideWith(
          (ref) => ConversationsStateNotifier(
            defaultConversations: mockConversations['123'],
          ),
        )
      ],
    );

    await tester.pumpWidget(
      materialAppWithTokens(
        tester: tester,
        child: UncontrolledProviderScope(
          container: container,
          child: Localizations(
            delegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            locale: const Locale('nl'),
            child: MaterialApp.router(
              routerConfig: router,
              localizationsDelegates: const [
                AppLocalizations.delegate,
              ],
            ),
          ),
        ),
      ),
    );

    return container;
  }

  testWidgets('Router redirects to onboarding if not finished',
      (WidgetTester tester) async {
    when(() => mockLocalStorage.isOnboardingFinished()).thenReturn(false);

    var router = createRouter();

    await setupWidget(tester, router);

    await tester.pumpAndSettle();

    expect(find.byType(OnboardingPage), findsOneWidget);
  });

  testWidgets('Router redirects to Chat page', (WidgetTester tester) async {
    var router = createRouter(isGridOverlayEnabled: true);

    tester.view.physicalSize = tabletViewSize;

    // FlutterError.onError = null;
    ignoreRenderFlexException();

    await setupWidget(tester, router);

    router.go('/chat-conversations');

    // Just pump without settle as progress indicator is shown
    await tester.pump(const Duration(microseconds: 1));

    expect(find.byType(ConversationsPage), findsOneWidget);
    tester.view.reset();
  });

  testWidgets('Router redirects to Chat Conversations page',
      (WidgetTester tester) async {
    var router = createRouter();

    var container = await setupWidget(tester, router);

    container.read(conversationViewModelProvider('1'));

    router.go('/chat-conversations/1');

    await tester.pumpAndSettle();

    // Just pump without settle as progress indicator is shown
    await tester.pump(const Duration(microseconds: 1));

    expect(find.byType(ConversationPageComponent), findsOneWidget);
  });

  testWidgets('Router shows 404 page when navigating to a non-existent page',
      (WidgetTester tester) async {
    when(() => mockLocalStorage.isOnboardingFinished()).thenReturn(false);

    var router = createRouter();

    await setupWidget(tester, router);

    router.go('/non-existent-page');

    await tester.pumpAndSettle();

    expect(find.byType(NotFoundPage), findsOneWidget);
  });

  testWidgets('Router navigates to developer settings page',
      (WidgetTester tester) async {
    var router = createRouter();

    await setupWidget(tester, router);

    router.go('/$devSettings');

    await tester.pumpAndSettle();

    expect(find.byType(DeveloperSettingsPage), findsOneWidget);
  });

  testWidgets('Router navigates to support home page',
      (WidgetTester tester) async {
    var router = createRouter();

    await setupWidget(tester, router);

    router.go('/$supportHome');

    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Router navigates to support question page',
      (WidgetTester tester) async {
    var router = createRouter();

    await setupWidget(tester, router);

    router.go('/$supportHome/$supportQuestionRoute/sample-question');

    await tester.pumpAndSettle();

    expect(find.byType(SupportQuestionPage), findsOneWidget);
  });

  testWidgets('Router navigates to support subject page',
      (WidgetTester tester) async {
    var router = createRouter();

    await setupWidget(tester, router);

    router.go('/$supportHome/$supportSubjectRoute/sample-subject');

    await tester.pumpAndSettle();

    expect(find.byType(SupportSubjectPage), findsOneWidget);
  });

  testWidgets('Router navigates to support question in subject page',
      (WidgetTester tester) async {
    var router = createRouter();

    await setupWidget(tester, router);

    router.go(
        '/$supportHome/$supportSubjectRoute/sample-subject/$supportQuestionRoute/sample-question');

    await tester.pumpAndSettle();

    expect(find.byType(SupportQuestionPage), findsOneWidget);
  });

  testWidgets('Router navigates to terms and conditions page',
      (WidgetTester tester) async {
    var router = createRouter();

    await setupWidget(tester, router);

    router.go('/$onboardingRoute/$termsAndConditionsRoute');

    await tester.pumpAndSettle();

    expect(find.byType(TermsAndConditionsPage), findsOneWidget);
  });

  testWidgets('Router navigates to login information page',
      (WidgetTester tester) async {
    var router = createRouter();

    await setupWidget(tester, router);

    router.go('/$onboardingRoute/$loginInformationRoute');

    await tester.pumpAndSettle();

    expect(find.byType(LoginInformationPage), findsOneWidget);
  });
}
