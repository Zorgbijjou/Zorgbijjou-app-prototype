import 'package:chat/models/conversation.dart';
import 'package:chat/models/conversation_messages.dart';

abstract class ChatDataSource {
  Future<List<Conversation>> fetchConversations();
  Future<ConversationMessages?> fetchMessages(String conversationId);
  Future<void> sendMessage(String conversationId, String message);
}
