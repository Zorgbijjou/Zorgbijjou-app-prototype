import 'package:chat/models/conversation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversations.freezed.dart';
part 'conversations.g.dart';

@freezed
class Conversations with _$Conversations {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory Conversations({
    required List<Conversation> conversations,
  }) = _Conversations;

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory Conversations.fromJson(Map<String, Object?> json) =>
      _$ConversationsFromJson(json);
}
