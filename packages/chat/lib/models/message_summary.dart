import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_summary.freezed.dart';
part 'message_summary.g.dart';

@freezed
class MessageSummary with _$MessageSummary {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory MessageSummary({
    required String text,
    required DateTime sentAt,
  }) = _MessageSummary;

  factory MessageSummary.fromJson(Map<String, Object?> json) =>
      _$MessageSummaryFromJson(json);
}
