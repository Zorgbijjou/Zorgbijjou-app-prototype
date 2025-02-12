import 'package:chat/data_source/chat_data_source.dart';
import 'package:chat/mocks/mock_chat_api.dart';
import 'package:core/core.dart';
import 'package:core/mocks/mock_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zorg_bij_jou/providers/conversation_page_provider.dart';
import 'package:zorg_bij_jou/providers/conversations_provider.dart';
import 'package:zorg_bij_jou/providers/time_providers.dart';

class MockChatDataSource extends Mock implements ChatDataSource {}

void main() {
  group('ConversationViewModelStateNotifier', () {
    late MockChatDataSource mockChatDataSource;
    var mockTimer = MockTimer.periodic(const Duration(minutes: 1), (timer) {});

    setUp(() {
      mockChatDataSource = MockChatDataSource();

      getIt.registerSingleton<ChatDataSource>(mockChatDataSource);
      getIt.registerSingleton<ZbjLogger>(MockLogger());

      when(() => mockChatDataSource.fetchConversations())
          .thenAnswer((_) => Future.value(mockConversations['123']));
    });

    tearDown(() {
      getIt.reset();
    });

    ProviderContainer createProviderContainer() {
      return ProviderContainer(overrides: [
        timerFactoryProvider
            .overrideWithValue((duration, callback) => mockTimer),
        conversationsStateProvider.overrideWith(
          (ref) => ConversationsStateNotifier(
            defaultConversations: mockConversations['123'],
          ),
        )
      ]);
    }

    test(
        'TestConversationViewModelStateNotifier fetch conversation and messages',
        () async {
      String conversationId = '1';

      var container = createProviderContainer();

      when(() => mockChatDataSource.fetchMessages(conversationId))
          .thenAnswer((_) => Future.value(mockConversationMessages[0]));

      container.read(conversationViewModelProvider(conversationId).notifier);

      await Future.delayed(Duration.zero);

      var viewModel =
          container.read(conversationViewModelProvider(conversationId));

      // Assert
      verify(() => mockChatDataSource.fetchMessages(conversationId)).called(1);

      expect(viewModel.conversationMessages, mockConversationMessages[0]);
      expect(viewModel.isLoading, equals(false));
      expect(viewModel.error, equals(null));

      container.dispose();
    });

    test('TestConversationViewModelStateNotifier fetch messages failure',
        () async {
      var container = createProviderContainer();

      String conversationId = '2';

      when(() => mockChatDataSource.fetchMessages(conversationId))
          .thenThrow(Exception('failed to fetch anything'));

      container.read(conversationViewModelProvider(conversationId).notifier);

      await Future.delayed(Duration.zero);

      var viewModel =
          container.read(conversationViewModelProvider(conversationId));

      // Assert
      expect(viewModel.conversationMessages, null);
      expect(viewModel.isLoading, equals(false));
      expect(viewModel.error, equals('Failed to fetch conversation'));

      container.dispose();
    });

    test('TestConversationViewModelStateNotifier send message', () async {
      var container = createProviderContainer();

      var conversationId = '1';

      when(() => mockChatDataSource.sendMessage(
              conversationId, 'this is a message'))
          .thenAnswer((_) => Future.value());

      when(() => mockChatDataSource.fetchMessages(conversationId))
          .thenAnswer((_) => Future.value());

      var viewModelNotifier = container
          .read(conversationViewModelProvider(conversationId).notifier);

      // Act
      await viewModelNotifier.onSendMessageThenRefresh('this is a message');

      var viewModel =
          container.read(conversationViewModelProvider(conversationId));

      // Assert
      expect(viewModel.error, equals(null));

      verify(() => mockChatDataSource.sendMessage(
          conversationId, 'this is a message')).called(1);

      container.dispose();
    });

    test(
        'TestConversationViewModelStateNotifier send message and fetch conversation',
        () async {
      var container = createProviderContainer();

      var conversationId = '1';

      when(() => mockChatDataSource.sendMessage(
              conversationId, 'this is a message'))
          .thenAnswer((_) => Future.value());
      when(() => mockChatDataSource.fetchMessages(conversationId))
          .thenAnswer((_) => Future.value());

      var viewModelNotifier = container
          .read(conversationViewModelProvider(conversationId).notifier);

      await Future.delayed(Duration.zero);

      // Act
      await viewModelNotifier.onSendMessageThenRefresh('this is a message');

      var viewModel =
          container.read(conversationViewModelProvider(conversationId));

      // Assert
      expect(viewModel.error, equals(null));

      verify(() => mockChatDataSource.fetchMessages(conversationId)).called(2);

      container.dispose();
    });

    test('TestConversationViewModelStateNotifier no empty message is send',
        () async {
      var container = createProviderContainer();

      var conversationId = '1';

      when(() => mockChatDataSource.fetchMessages(conversationId))
          .thenAnswer((_) => Future.value(mockConversationMessages[0]));
      when(() => mockChatDataSource.fetchMessages(conversationId))
          .thenAnswer((_) => Future.value());

      var viewModelNotifier = container
          .read(conversationViewModelProvider(conversationId).notifier);

      await Future.delayed(Duration.zero);

      // Act
      await viewModelNotifier.onSendMessageThenRefresh('');

      var viewModel =
          container.read(conversationViewModelProvider(conversationId));

      // Assert
      expect(viewModel.error, equals(null));

      verifyNever(() => mockChatDataSource.sendMessage(conversationId, any()));
      verify(() => mockChatDataSource.fetchMessages(conversationId)).called(1);

      container.dispose();
    });

    test('TestConversationViewModelStateNotifier send message failure',
        () async {
      var container = createProviderContainer();

      var conversationId = '1';

      when(() => mockChatDataSource.fetchMessages(conversationId))
          .thenAnswer((_) => Future.value(mockConversationMessages[0]));

      var viewModelNotifier = container
          .read(conversationViewModelProvider(conversationId).notifier);

      await Future.delayed(Duration.zero);

      when(() =>
              mockChatDataSource.sendMessage(conversationId, 'Why do I fail?'))
          .thenThrow(Exception("I don't expect failures"));

      // Act
      await viewModelNotifier.onSendMessageThenRefresh('Why do I fail?');

      await Future.delayed(Duration.zero);

      var viewModel =
          container.read(conversationViewModelProvider(conversationId));

      expect(viewModel.error, equals('Failed to send message'));

      verify(() => mockChatDataSource.fetchMessages(conversationId)).called(1);

      container.dispose();
    });

    // should update unreadMessagesCount for new messages
    test(
        'TestConversationViewModelStateNotifier update unreadMessagesCount and they should stack',
        () async {
      var container = createProviderContainer();

      var conversationId = '1';

      var conversationsWithUnreadMessages =
          mockConversations['123']!.map((conversation) {
        return conversation.copyWith(numberOfUnreadMessages: 1);
      }).toList();

      when(() => mockChatDataSource.fetchMessages(conversationId))
          .thenAnswer((_) => Future.value(mockConversationMessages[0]));

      when(() => mockChatDataSource.fetchConversations())
          .thenAnswer((_) => Future.value(conversationsWithUnreadMessages));

      container.read(conversationViewModelProvider(conversationId));

      await Future.delayed(Duration.zero);

      // Act
      container.read(conversationsStateProvider.notifier).fetchData();

      await Future.delayed(Duration.zero);

      // Assert
      var viewModel =
          container.read(conversationViewModelProvider(conversationId));
      expect(viewModel.unreadMessagesCount, equals(2));

      container.dispose();
    });
  });
}
