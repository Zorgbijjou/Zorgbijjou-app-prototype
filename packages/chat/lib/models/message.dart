import 'package:chat/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory Message({
    required String text,
    required DateTime sentAt,
    @Default(false) bool isSystemMessage,
    User? user,
  }) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}
