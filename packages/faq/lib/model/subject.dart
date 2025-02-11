import 'package:freezed_annotation/freezed_annotation.dart';

import 'question_reference.dart';

part 'subject.freezed.dart';
part 'subject.g.dart';

@freezed
class Subject with _$Subject {
  @JsonSerializable(fieldRename: FieldRename.kebab)
  const factory Subject({
    required String slug,
    required String titleKey,
    required int order,
    required String image,
    String? introductionKey,
    @Default({}) QuestionReferenceList questions,
  }) = _Subject;

  factory Subject.fromJson(Map<String, Object?> json) =>
      _$SubjectFromJson(json);
}
