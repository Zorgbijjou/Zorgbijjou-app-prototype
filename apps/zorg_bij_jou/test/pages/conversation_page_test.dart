import 'dart:async';

import 'package:chat/data_source/chat_data_source.dart';
import 'package:chat/mocks/mock_chat_api.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:zorg_bij_jou/pages/conversation_page.dart';
import 'package:zorg_bij_jou/providers/conversation_page_provider.dart';
import 'package:zorg_bij_jou/providers/conversations_provider.dart';
import 'package:zorg_bij_jou/providers/time_providers.dart';

import '../helpers.dart';

void main() {
  MockChatDataSource mockChatDataSource = MockChatDataSource();
  MockTimer mockTimer =
      MockTimer.periodic(const Duration(minutes: 1), (timer) {});

  setUp(() async {
    getIt.registerSingleton<ChatDataSource>(mockChatDataSource);
    getIt.registerFactory<Timer>(() => mockTimer);
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('ConversationPage test', (WidgetTester tester) async {
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

    container.read(conversationViewModelProvider('1').notifier);

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
            child: const ConversationPage(conversationId: '1'),
          ),
        ),
      ),
    );

    // pump
    await tester.pumpAndSettle();

    expect(find.text('Zorgbijjou'), findsOneWidget);
    expect(find.text('Bedankt, ik ga rond kijken in de app'), findsOneWidget);
  });

  testWidgets('ConversationsPage on send message', (WidgetTester tester) async {
    String conversationId = '1';
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

    container.read(conversationViewModelProvider(conversationId).notifier);

    when(() => mockChatDataSource.sendMessage(
            conversationId, 'hi, this is a message'))
        .thenAnswer((_) => Future.value());

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
            child: const ConversationPage(conversationId: '1'),
          ),
        ),
      ),
    );

    // pump
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'hi, this is a message');
    await tester.pumpAndSettle();

    expect(find.text('hi, this is a message'), findsOneWidget);

    var backButtonFinder = find.byIcon(CustomIcons.send_01);
    await tester.tap(backButtonFinder);

    expect(find.text('hi, this is a message'), findsNothing);
  });
}
