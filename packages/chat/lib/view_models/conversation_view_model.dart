import 'package:chat/models/conversation.dart';
import 'package:chat/models/conversation_messages.dart';
import 'package:chat/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_view_model.freezed.dart';

@freezed
class ConversationViewModel with _$ConversationViewModel {
  const ConversationViewModel._();

  const factory ConversationViewModel({
    @Default(true) bool isLoading,
    required String conversationId,
    Conversation? conversation,
    @Default(0) int unreadMessagesCount,
    ConversationMessages? conversationMessages,
    String? error,
  }) = _ConversationViewModel;

  List<Message> get richMessages {
    return conversationMessages?.messages ?? [];
  }

  int get focusMessageIndex {
    if (richMessages.isEmpty) {
      return 0;
    }

    return (richMessages.length - 1) - unreadMessagesCount;
  }

  bool isConsecutiveMessageOfUser(Message message) {
    int index = richMessages.indexOf(message);
    if (index == 0) {
      return false;
    }

    var user = message.user;
    var userPreviousMessage = richMessages[index - 1].user;

    if (user == null || userPreviousMessage == null) {
      return false;
    }

    return user.name == userPreviousMessage.name &&
        user.type == userPreviousMessage.type;
  }

  String get practitionerName {
    return conversation?.practitioner ?? '';
  }
}
