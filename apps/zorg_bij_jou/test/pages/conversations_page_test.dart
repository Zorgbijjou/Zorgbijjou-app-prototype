import 'dart:async';

import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:zorg_bij_jou/pages/conversations_page.dart';
import 'package:zorg_bij_jou/providers/conversations_page_provider.dart';
import 'package:zorg_bij_jou/providers/time_providers.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

import '../helpers.dart';

void main() {
  late MockChatDataSource mockChatDataSource;
  late MockTimer mockTimer;

  setUp(() async {
    var localeStorage = MockLocalStorage();
    when(() => localeStorage.getCode()).thenReturn('123');
    getIt.registerSingleton<LocalStorage>(localeStorage);

    mockChatDataSource = MockChatDataSource();
    when(() => mockChatDataSource.fetchConversations())
        .thenAnswer((_) => Future.value(mockConversations['123']));
    getIt.registerSingleton<ChatDataSource>(mockChatDataSource);

    mockTimer = MockTimer.periodic(const Duration(minutes: 1), (timer) {});
    getIt.registerFactory<Timer>(() => mockTimer);
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('ConversationsPage test', (WidgetTester tester) async {
    ignoreRenderFlexException();

    var container = ProviderContainer(overrides: [
      timerFactoryProvider.overrideWithValue((duration, callback) => mockTimer),
    ]);

    container.read(conversationsViewModelProvider.notifier);

    tester.view.physicalSize = phoneViewSize;

    // Act
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: materialAppWithTokens(
          tester: tester,
          child: Localizations(
            locale: const Locale('nl'),
            delegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            child: const ConversationsPage(),
          ),
        ),
      ),
    );

    // pump
    await tester.pumpAndSettle(const Duration(seconds: 10));

    expect(find.byType(ConversationsTabletComponent), findsNothing);

    expect(find.text('Zorgbijjou'), findsOneWidget);
    expect(
        find.text(
            'In deze chat kan je alle vragen stellen die je hebt rondom het gebruik van deze app en nog meer dingen.'),
        findsOneWidget);

    tester.view.reset();

    container.dispose();
  });

  testWidgets(
      'ConversationsPage should go conversation page when clicking on conversation item',
      (WidgetTester tester) async {
    var mockGoRouter = MockGoRouter();
    var container = ProviderContainer(overrides: [
      timerFactoryProvider.overrideWithValue((duration, callback) => mockTimer),
    ]);

    container.read(conversationsViewModelProvider.notifier);

    var conversation = mockConversation;

    // when mockRouter push
    when(() => mockGoRouter.push('/$chatConversations/${conversation.id}',
        extra: conversation)).thenAnswer((_) => Future.value());

    tester.view.physicalSize = phoneViewSize;

    // Act
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: materialAppWithTokens(
            tester: tester,
            child: Localizations(
              delegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              locale: const Locale('nl'),
              child: const ConversationsPage(),
            ),
          ),
        ),
      ),
    );

    // pump
    await tester.pumpAndSettle();

    expect(find.text(conversation.practitioner), findsOneWidget);
    await tester.tapAt(tester.getCenter(find.text(conversation.practitioner)));
    await tester.pumpAndSettle();

    // Verify that we are on
    verify(() => mockGoRouter.push('/$chatConversations/${conversation.id}',
        extra: conversation)).called(1);

    tester.view.reset();
  });

  testWidgets(
      'ConversationsPage should display tablet view layout and load message of the first conversation',
      (WidgetTester tester) async {
    var container = ProviderContainer(overrides: [
      timerFactoryProvider.overrideWithValue((duration, callback) => mockTimer),
    ]);

    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: materialAppWithTokens(
          tester: tester,
          child: Localizations(
            locale: const Locale('nl'),
            delegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            child: const ConversationsPage(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ConversationsTabletComponent), findsOneWidget);

    var expectedConversationMessage =
        mockConversationMessages[0].messages![1].text;
    expect(find.text(expectedConversationMessage), findsOne);
  });

  testWidgets(
      'ConversationsPage should get messages for the other conversation when conversation is changed',
      (WidgetTester tester) async {
    var container = ProviderContainer(overrides: [
      timerFactoryProvider.overrideWithValue((duration, callback) => mockTimer),
    ]);

    container.read(conversationsViewModelProvider.notifier);

    // Set screen width to simulate tablet
    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: materialAppWithTokens(
          tester: tester,
          child: Localizations(
            locale: const Locale('nl'),
            delegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            child: const ConversationsPage(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that the tablet layout is displayed
    expect(find.byType(ConversationsTabletComponent), findsOneWidget);

    // Verify initial conversation messages are displayed
    var initialConversationMessage =
        mockConversationMessages[0].messages![0].text;
    expect(find.text(initialConversationMessage), findsOneWidget);

    // Change the active conversation

    var newConversation = mockConversations.values.first.elementAt(1);

    await tester.tap(find.text(newConversation.practitioner));
    await tester.pumpAndSettle();

    // Verify new conversation messages are displayed
    var newConversationMessage = mockConversationMessages[1].messages![1].text;
    expect(find.text(newConversationMessage), findsOneWidget);
  });

  testWidgets(
      'ConversationsPage should send a message and update the conversation',
      (WidgetTester tester) async {
    var container = ProviderContainer(overrides: [
      timerFactoryProvider.overrideWithValue((duration, callback) => mockTimer),
    ]);

    container.read(conversationsViewModelProvider.notifier);

    // Set screen width to simulate tablet
    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;

    when(() => mockChatDataSource.sendMessage(any(), any()))
        .thenAnswer((_) => Future.value());

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: materialAppWithTokens(
          tester: tester,
          child: Localizations(
            locale: const Locale('nl'),
            delegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            child: const ConversationsPage(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that the tablet layout is displayed
    expect(find.byType(ConversationsTabletComponent), findsOneWidget);

    // Verify initial conversation messages are displayed
    var initialConversationMessage =
        mockConversationMessages[0].messages![0].text;
    expect(find.text(initialConversationMessage), findsOneWidget);

    // Simulate sending a message
    var messageText = 'Hello, this is a test message';
    await tester.enterText(find.byType(TextField), messageText);

    var backButtonFinder = find.byIcon(CustomIcons.send_01);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();

    verify(() =>
            mockChatDataSource.sendMessage(mockConversation.id, messageText))
        .called(1);
  });
}
