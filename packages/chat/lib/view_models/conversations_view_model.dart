import 'package:chat/models/conversation.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversations_view_model.freezed.dart';

@freezed
class ConversationsViewModel with _$ConversationsViewModel {
  const ConversationsViewModel._();

  const factory ConversationsViewModel({
    @Default(true) bool isLoading,
    @Default(null) List<Conversation>? conversations,
    String? error,
  }) = _ConversationsViewModel;

  List<Conversation> get conversationsOrdered =>
      (conversations ?? []).sorted((a, b) {
        if (a.numberOfUnreadMessages > 0 && b.numberOfUnreadMessages == 0) {
          return -1;
        } else if (a.numberOfUnreadMessages == 0 &&
            b.numberOfUnreadMessages > 0) {
          return 1;
        } else {
          return b.lastMessage?.sentAt
                  .compareTo(a.lastMessage?.sentAt ?? DateTime(0)) ??
              0;
        }
      });
}
