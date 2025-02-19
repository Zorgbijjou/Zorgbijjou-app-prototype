import 'package:freezed_annotation/freezed_annotation.dart';

import 'question.dart';
import 'question_reference.dart';
import 'subject.dart';

part 'toc.freezed.dart';
part 'toc.g.dart';

@freezed
class Toc with _$Toc {
  @JsonSerializable(fieldRename: FieldRename.kebab)
  const factory Toc({
    @Default({}) Map<String, QuestionReference> frequentlyAskedQuestions,
    @Default({}) Map<String, Subject> subjects,
    @Default({}) Map<String, Question> questions,
  }) = _Toc;

  factory Toc.fromJson(Map<String, Object?> json) => _$TocFromJson(json);
}
