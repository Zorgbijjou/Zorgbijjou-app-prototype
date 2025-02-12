import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_reference.freezed.dart';
part 'question_reference.g.dart';

typedef QuestionReferenceList = Map<String, QuestionReference>;

@freezed
class QuestionReference with _$QuestionReference {
  @JsonSerializable(fieldRename: FieldRename.kebab)
  const factory QuestionReference({
    @Default(-1) int? order,
  }) = _QuestionReference;

  factory QuestionReference.fromJson(Map<String, Object?> json) =>
      _$QuestionReferenceFromJson(json);
}
