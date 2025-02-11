import 'package:chat/data_source/chat_data_source_impl.dart';
import 'package:chat/models/conversation.dart';
import 'package:chat/models/conversation_messages.dart';
import 'package:core/auth/auth.dart';
import 'package:core/locator/locator.dart';
import 'package:core/logging/console_logger.dart';
import 'package:core/logging/zbj_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockAuth extends Mock implements Auth {}

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

class MockPrinter extends Mock {
  void call(Object? params);
}

void main() {
  MockClient client = MockClient();
  MockAuth mockAuth = MockAuth();
  ChatDataSourceImpl dataSource =
      ChatDataSourceImpl(client: client, auth: mockAuth);

  setUpAll(() {
    registerFallbackValue(FakeUri());
    var mockPrinter = MockPrinter();
    getIt.registerSingletonAsync<ZbjLogger>(
        () => ConsoleLogger(printer: mockPrinter.call).initialize(),
        instanceName: 'console');

    when(() => mockAuth.getAccessToken())
        .thenAnswer((_) => Future.value('test_token'));
  });

  group('ChatDataSourceImpl fetchConversations', () {
    test('fetchConversations returns a list of conversations', () async {
      List<Conversation> result = await dataSource.fetchConversations();

      expect(result, isA<List<Conversation>>());
      expect(result.length, 2);
    });
  });

  group('ChatDataSourceImpl fetchConversation', () {
    test('fetchConversation returns empty result', () async {
      ConversationMessages? result =
          await dataSource.fetchMessages('conversation-id');

      expect(result, equals(null));
    });
  });

  group('ChatDataSourceImpl sendMessage', () {
    test('sendMessage correctly', () async {
      await dataSource.sendMessage('conversation-id', 'message');
    });
  });
}
