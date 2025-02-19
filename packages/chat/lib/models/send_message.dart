import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message.freezed.dart';
part 'send_message.g.dart';

@freezed
class SendMessage with _$SendMessage {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory SendMessage({
    required String text,
  }) = _SendMessage;

  @JsonSerializable(
    fieldRename: FieldRename.pascal,
  )
  factory SendMessage.fromJson(Map<String, Object?> json) =>
      _$SendMessageFromJson(json);
}
