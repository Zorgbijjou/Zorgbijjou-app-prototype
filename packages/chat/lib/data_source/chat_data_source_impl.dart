import 'dart:async';

import 'package:chat/chat.dart';
import 'package:chat/models/conversation_messages.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/user.dart';
import 'package:core/core.dart';
import 'package:http/http.dart';

class ChatDataSourceImpl extends ChatDataSource {
  final Client client;
  final Auth auth;

  List<Conversation> conversations = mockConversations['123']!
      .map(
        (c) => c.copyWith(
            numberOfUnreadMessages: 0,
            lastMessage: c.lastMessage
                ?.copyWith(sentAt: DateTime.parse('2025-01-29T09:30:00.420'))),
      )
      .toList();
  Map<String, ConversationMessages> messageCache = {
    for (var c in mockConversationMessages) c.id: c
  };

  List<String> systemMessagesSent = [];

  ChatDataSourceImpl({
    required this.client,
    required this.auth,
  });

  @override
  Future<List<Conversation>> fetchConversations() async {
    return Future.value(conversations);
  }

  @override
  Future<ConversationMessages?> fetchMessages(String conversationId) async {
    conversations = conversations.map((c) {
      if (c.id == conversationId) {
        return c.copyWith(numberOfUnreadMessages: 0);
      }
      return c;
    }).toList();

    return Future.value(messageCache[conversationId]);
  }

  @override
  Future<void> sendMessage(String conversationId, String message) async {
    ConversationMessages conversationMessages = messageCache[conversationId] ??
        ConversationMessages(id: conversationId, practitioner: 'Zorgbijjou');

    List<Message> messages =
        List<Message>.from(conversationMessages.messages ?? [])
          ..add(Message(
            sentAt: DateTime.now(),
            isSystemMessage: false,
            user: const User(name: 'Patient', type: 'patient'),
            text: message,
          ));

    if (!systemMessagesSent.contains(conversationId)) {
      messages.add(Message(
        sentAt: DateTime.now(),
        user: const User(name: 'Zorgbijjou', type: 'practitioner'),
        text: systemNotAvailable,
      ));
      systemMessagesSent.add(conversationId);
    }

    messageCache[conversationId] =
        conversationMessages.copyWith(messages: messages);

    return Future.value();
  }
}
