import 'package:freezed_annotation/freezed_annotation.dart';

import 'message.dart';

part 'conversation_messages.freezed.dart';
part 'conversation_messages.g.dart';

@freezed
class ConversationMessages with _$ConversationMessages {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory ConversationMessages({
    required String id,
    required String practitioner,
    List<Message>? messages,
  }) = _ConversationMessages;

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  factory ConversationMessages.fromJson(Map<String, Object?> json) =>
      _$ConversationMessagesFromJson(json);
}
