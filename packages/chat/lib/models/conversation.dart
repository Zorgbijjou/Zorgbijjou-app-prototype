import 'package:chat/models/message_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory Conversation({
    required String id,
    required String practitioner,
    required bool isClosed,
    MessageSummary? lastMessage,
    required int numberOfUnreadMessages,
  }) = _Conversation;

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory Conversation.fromJson(Map<String, Object?> json) =>
      _$ConversationFromJson(json);
}
