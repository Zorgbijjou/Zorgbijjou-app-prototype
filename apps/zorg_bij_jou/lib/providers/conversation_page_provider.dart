import 'package:chat/data_source/chat_data_source.dart';
import 'package:chat/models/conversation.dart';
import 'package:chat/view_models/conversation_view_model.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zorg_bij_jou/providers/provider_extensions.dart';

import 'conversations_provider.dart';

final conversationViewModelProvider = StateNotifierProvider.family<
        ConversationViewModelStateNotifier, ConversationViewModel, String>(
    (ref, conversationId) =>
        ConversationViewModelStateNotifier(ref, conversationId));

class ConversationViewModelStateNotifier
    extends StateNotifier<ConversationViewModel> {
  final ChatDataSource dataSource = getIt();
  final String fetchConversationFailedEvent = 'fetchConversation failed';
  final String onSendMessageFailedEvent = 'onSendMessage failed';
  final TextEditingController sendMessageController = TextEditingController();

  ConversationViewModelStateNotifier(Ref ref, String conversationId)
      : super(ConversationViewModel(
          isLoading: true,
          conversationId: conversationId,
        )) {
    ref.readAndListen(
        conversationsStateProvider, onSetConversationAndFetchMessages);
  }

  void onSetConversationAndFetchMessages(
      ConversationsResult conversationsResult) {
    var conversations = conversationsResult.conversations ?? [];
    var conversation = conversations
        .firstWhere((element) => element.id == state.conversationId);

    state = state.copyWith(
      conversation: conversation,
    );

    if (conversation.numberOfUnreadMessages == 0 &&
        state.richMessages.isNotEmpty) {
      return;
    }

    _fetchConversationMessages().then((_) {
      _onUpdateUnreadMessagesCount(conversation);
    });
  }

  Future<bool> _fetchConversationMessages() async {
    try {
      var conversationMessages =
          await dataSource.fetchMessages(state.conversationId);

      state = state.copyWith(
        isLoading: false,
        error: null,
        conversationMessages: conversationMessages,
      );
      return true;
    } on Exception catch (e) {
      severe('fetchConversation', '$e');
      customEvent(fetchConversationFailedEvent,
          {'conversation': state.conversationId, 'error': '$e'});
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to fetch conversation',
      );
      return false;
    }
  }

  _onUpdateUnreadMessagesCount(Conversation conversation) {
    var currentUnreadMessagesCount = state.unreadMessagesCount;
    var newUnreadMessagesCount =
        conversation.numberOfUnreadMessages + currentUnreadMessagesCount;

    state = state.copyWith(
      conversation: conversation,
      unreadMessagesCount: newUnreadMessagesCount,
    );
  }

  Future onSendMessageThenRefresh(String message) async {
    return _onSendMessage(message).then((fetchSuccessful) {
      if (fetchSuccessful) {
        return _fetchConversationMessages();
      }
    });
  }

  Future<bool> _onSendMessage(String message) async {
    if (message.trim().isEmpty) {
      return false;
    }

    try {
      await dataSource.sendMessage(state.conversationId, message);

      state = state.copyWith(
        error: null,
      );

      return true;
    } on Exception catch (e) {
      severe('onSendMessage', '$e');
      customEvent(fetchConversationFailedEvent, {
        'conversation': state.conversationId,
        'message': message,
        'error': '$e'
      });
      state = state.copyWith(
        error: 'Failed to send message',
      );
      return false;
    }
  }
}
