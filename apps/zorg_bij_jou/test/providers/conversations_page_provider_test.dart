import 'dart:async';

import 'package:chat/data_source/chat_data_source.dart';
import 'package:chat/mocks/mock_chat_api.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zorg_bij_jou/providers/conversations_page_provider.dart';
import 'package:zorg_bij_jou/providers/time_providers.dart';

import '../helpers.dart';

void main() {
  group('ConversationsViewModelStateNotifier', () {
    var chatDataSource = MockChatDataSource();
    late MockTimer mockTimer;

    setUp(() {
      getIt.registerSingleton<Auth>(MockAuth());
      getIt.registerSingleton<ChatDataSource>(chatDataSource);

      mockTimer = MockTimer.periodic(const Duration(minutes: 1), (timer) {});
      getIt.registerFactory<Timer>(() => mockTimer);
    });

    tearDown(() {
      getIt.reset();
    });

    test(
        'Test ConversationsViewModelStateNotifier should initialize with conversations',
        () async {
      var container = ProviderContainer(
        overrides: [
          timerFactoryProvider
              .overrideWithValue((duration, callback) => mockTimer),
        ],
      );

      when(() => chatDataSource.fetchConversations())
          .thenAnswer((_) => Future.value(mockConversations['123']));

      container.read(conversationsViewModelProvider);
      await Future.delayed(Duration.zero);

      var viewModel = container.read(conversationsViewModelProvider);

      // Assert
      expect(viewModel.conversations, mockConversations['123']);
      expect(viewModel.isLoading, equals(false));
      expect(viewModel.error, equals(null));
    });
  });
}
