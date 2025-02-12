import 'package:chat/models/conversation.dart';
import 'package:chat/models/message_summary.dart';
import 'package:chat/view_models/conversations_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

Conversation aConversation({
  required String id,
  required int numberUnread,
  int? minutesAgo,
}) {
  return Conversation(
    id: id,
    practitioner: 'The Practitioner $id',
    numberOfUnreadMessages: numberUnread,
    isClosed: false,
    lastMessage: (minutesAgo != null)
        ? MessageSummary(
            text: 'Message text $id',
            sentAt: DateTime.now().subtract(Duration(minutes: minutesAgo)))
        : null,
  );
}

void main() {
  group('ConversationsViewModel', () {
    test('should have default values', () {
      ConversationsViewModel viewModel = const ConversationsViewModel();

      expect(viewModel.isLoading, true);
      expect(viewModel.conversations, null);
      expect(viewModel.error, null);
    });

    test('conversationsOrdered should be sorted by message sentAt', () {
      List<Conversation> conversations = [
        aConversation(id: '1', numberUnread: 0, minutesAgo: 3),
        aConversation(id: '2', numberUnread: 0, minutesAgo: 2),
        aConversation(id: '3', numberUnread: 0, minutesAgo: 1),
      ];

      ConversationsViewModel viewModel = ConversationsViewModel(
        conversations: conversations,
      );

      List<Conversation> orderedConversations = viewModel.conversationsOrdered;

      expect(orderedConversations[0].id, '3');
      expect(orderedConversations[1].id, '2');
      expect(orderedConversations[2].id, '1');
    });

    test('conversationsOrdered should be sorted by unread messages and sentAt',
        () {
      List<Conversation> conversations = [
        aConversation(id: '1', numberUnread: 0, minutesAgo: 1),
        aConversation(id: '2', numberUnread: 2, minutesAgo: 2),
        aConversation(id: '3', numberUnread: 1, minutesAgo: 3),
      ];

      ConversationsViewModel viewModel = ConversationsViewModel(
        isLoading: false,
        conversations: conversations,
        error: null,
      );

      List<Conversation> orderedConversations = viewModel.conversationsOrdered;

      expect(orderedConversations[0].id, '2');
      expect(orderedConversations[1].id, '3');
      expect(orderedConversations[2].id, '1');
    });

    test('conversationsOrdered should be sorted if there is no last message',
        () {
      List<Conversation> conversations = [
        aConversation(id: '1', numberUnread: 0),
        aConversation(id: '2', numberUnread: 0, minutesAgo: 2),
        aConversation(id: '3', numberUnread: 0, minutesAgo: 3),
      ];

      ConversationsViewModel viewModel = ConversationsViewModel(
        isLoading: false,
        conversations: conversations,
        error: null,
      );

      List<Conversation> orderedConversations = viewModel.conversationsOrdered;

      expect(orderedConversations[0].id, '2');
      expect(orderedConversations[1].id, '3');
      expect(orderedConversations[2].id, '1');
    });
  });
}
