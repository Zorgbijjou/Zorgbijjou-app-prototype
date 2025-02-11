import 'package:chat/data_source/chat_data_source.dart';
import 'package:chat/mocks/mock_chat_api.dart';
import 'package:core/core.dart';
import 'package:core/mocks/mock_logger.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zorg_bij_jou/providers/conversations_provider.dart';

class MockConversationsStateNotifier extends Mock
    implements ConversationsStateNotifier {}

void main() {
  late MockChatDataSource mockChatDataSource;
  late MockLogger logger;

  setUp(() async {
    logger = MockLogger();
    getIt.registerSingleton<ZbjLogger>(logger);

    mockChatDataSource = MockChatDataSource();
    getIt.registerSingleton<ChatDataSource>(mockChatDataSource);
  });

  tearDown(() async {
    await getIt.reset();
  });

  test(
      'conversationsStateProvider fetches data initially and doesnt refresh after 59 seconds',
      () async {
    fakeAsync((async) {
      // initialize fetch of conversations
      when(() => mockChatDataSource.fetchConversations())
          .thenAnswer((_) => Future.value(mockConversations['123']));

      var container = ProviderContainer();

      // initialize the provider
      container.read(conversationsStateProvider);

      async.elapse(const Duration(milliseconds: 1));

      var viewModel = container.read(conversationsStateProvider);
      expect(viewModel.conversations, mockConversations['123']);
      expect(viewModel.isLoading, equals(false));
      expect(viewModel.error, equals(null));

      // simulate a new fetch that should not happen
      when(() => mockChatDataSource.fetchConversations())
          .thenAnswer((_) => Future.value(mockConversations['456']));

      async.elapse(const Duration(seconds: 59));

      // get the new value of the provider
      viewModel = container.read(conversationsStateProvider);

      expect(viewModel.conversations, mockConversations['123']);
      expect(viewModel.isLoading, equals(false));
      expect(viewModel.error, equals(null));

      verify(() => mockChatDataSource.fetchConversations()).called(1);

      container.dispose();
    });
  });

  test(
      'conversationsStateProvider fetches data initially and should periodically refresh every 1 minute',
      () async {
    fakeAsync((async) {
      // initialize fetch of conversations
      when(() => mockChatDataSource.fetchConversations())
          .thenAnswer((_) => Future.value(mockConversations['123']));

      var container = ProviderContainer();
      container.read(conversationsStateProvider);

      async.elapse(const Duration(milliseconds: 1));

      var viewModel = container.read(conversationsStateProvider);
      expect(viewModel.conversations, mockConversations['123']);

      // first periodic fetch after 1 minute
      when(() => mockChatDataSource.fetchConversations())
          .thenAnswer((_) => Future.value(mockConversations['456']));
      async.elapse(const Duration(minutes: 1));

      viewModel = container.read(conversationsStateProvider);
      expect(viewModel.conversations, mockConversations['456']);

      // second periodic fetch 1 minute later
      when(() => mockChatDataSource.fetchConversations())
          .thenAnswer((_) => Future.value(mockConversations['123']));
      async.elapse(const Duration(minutes: 1));

      viewModel = container.read(conversationsStateProvider);
      expect(viewModel.conversations, mockConversations['123']);

      container.dispose();
    });
  });

  test(
      'conversationsStateProvider is initialized that it is loading and no error',
      () async {
    fakeAsync((async) {
      when(() => mockChatDataSource.fetchConversations())
          .thenAnswer((_) => Future.value(mockConversations['123']));

      var container = ProviderContainer();
      container.read(conversationsStateProvider);

      var viewModel = container.read(conversationsStateProvider);
      expect(viewModel.conversations, null);
      expect(viewModel.isLoading, equals(true));
      expect(viewModel.error, equals(null));

      container.dispose();
    });
  });

  test('conversationsStateProvider fetches data with error result', () async {
    getIt.unregister<ChatDataSource>();

    var mockChatDataSource = LocalMockChatDataSource();
    getIt.registerSingleton<ChatDataSource>(mockChatDataSource);

    fakeAsync((async) {
      // initialize fetch of conversations
      when(() => mockChatDataSource.fetchConversations())
          .thenThrow(Exception('No refresh token found'));

      var container = ProviderContainer();
      container.read(conversationsStateProvider);

      async.elapse(const Duration(milliseconds: 1));

      var viewModel = container.read(conversationsStateProvider);
      expect(viewModel.conversations, null);
      expect(viewModel.isLoading, equals(false));
      expect(viewModel.error, equals('Failed to fetch conversations'));

      verify(() => logger.customEvent('fetchConversations failed', any()));

      container.dispose();
    });
  });
}

class LocalMockChatDataSource extends Mock implements ChatDataSource {}
