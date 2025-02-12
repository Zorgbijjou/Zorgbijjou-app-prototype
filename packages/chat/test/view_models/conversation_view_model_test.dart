import 'package:chat/mocks/mock_chat_api.dart';
import 'package:chat/models/conversation.dart';
import 'package:chat/models/conversation_messages.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/user.dart';
import 'package:chat/view_models/conversation_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConversationViewModel', () {
    test('should have default values', () {
      ConversationViewModel viewModel = const ConversationViewModel(
        conversationId: '123',
        conversation: null,
      );

      expect(viewModel.isLoading, true);
      expect(viewModel.conversationId, '123');
      expect(viewModel.conversation, null);
      expect(viewModel.conversationMessages, null);
      expect(viewModel.error, null);
    });

    test('should return empty list when conversationMessages is null', () {
      ConversationViewModel viewModel = const ConversationViewModel(
        conversationId: '123',
        conversation: null,
      );

      expect(viewModel.richMessages, []);
    });

    test('should return rich messages when conversationMessages is not null',
        () {
      List<Message> messages = [
        Message(
            user: const User(name: 'name', type: 'patient'),
            text: 'Hello',
            sentAt: DateTime.now()),
        Message(
            user: const User(name: 'name', type: 'patient'),
            text: 'World',
            sentAt: DateTime.now()),
      ];

      ConversationMessages conversationMessages = ConversationMessages(
        messages: messages,
        id: '123',
        practitioner: 'Dr. John Doe',
      );

      ConversationViewModel viewModel = ConversationViewModel(
        conversationId: '123',
        conversation: null,
        conversationMessages: conversationMessages,
      );

      List<Message> richMessages = viewModel.richMessages;
      expect(richMessages.length, 2);
      expect(richMessages[0].text, 'Hello');
      expect(richMessages[1].text, 'World');
    });

    test('should return true or false if the message is consecutive', () {
      List<Message> messages = mockConsecutiveMessages;

      ConversationMessages conversationMessages = ConversationMessages(
        messages: messages,
        id: '123',
        practitioner: 'Dr. John Doe',
      );

      ConversationViewModel viewModel = ConversationViewModel(
        conversationId: '123',
        conversation: null,
        conversationMessages: conversationMessages,
      );

      expect(viewModel.isConsecutiveMessageOfUser(messages[0]), false);
      expect(viewModel.isConsecutiveMessageOfUser(messages[1]), true);
      expect(viewModel.isConsecutiveMessageOfUser(messages[2]), false);
      expect(viewModel.isConsecutiveMessageOfUser(messages[3]), true);
      expect(viewModel.isConsecutiveMessageOfUser(messages[4]), false);
      expect(viewModel.isConsecutiveMessageOfUser(messages[5]), false);
    });

    test('focusMessageIndex should return 0 when there are no rich messages',
        () {
      ConversationViewModel viewModel = const ConversationViewModel(
        conversationId: '123',
        conversation: null,
      );

      expect(viewModel.focusMessageIndex, 0);
    });

    test(
        'focusMessageIndex should return the correct index of the first unread message',
        () {
      List<Message> messages = List.generate(5, (index) {
        return Message(
            user: const User(name: 'name', type: 'patient'),
            text: 'Hello $index',
            sentAt: DateTime.now());
      });

      ConversationMessages conversationMessages = ConversationMessages(
        messages: messages,
        id: '123',
        practitioner: 'Dr. John Doe',
      );

      Conversation conversation = const Conversation(
        id: '123',
        numberOfUnreadMessages: 0,
        practitioner: 'Dr. John Doe',
        isClosed: false,
      );

      ConversationViewModel viewModel = ConversationViewModel(
        conversationId: '123',
        conversation: conversation,
        conversationMessages: conversationMessages,
        unreadMessagesCount: 3,
      );

      expect(viewModel.focusMessageIndex, 1);
    });
  });
}
