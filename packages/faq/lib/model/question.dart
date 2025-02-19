import 'package:freezed_annotation/freezed_annotation.dart';

import 'question_reference.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  @JsonSerializable(fieldRename: FieldRename.kebab)
  const factory Question({
    required String slug,
    required String titleKey,
    required DateTime modifiedDate,
    String? introductionKey,
    @Default({}) QuestionReferenceList relatedQuestions,
    int? order,
  }) = _Question;

  factory Question.fromJson(Map<String, Object?> json) =>
      _$QuestionFromJson(json);
}
