import 'package:faq/model/question.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_question_view_model.freezed.dart';

@freezed
class SupportQuestionViewModel with _$SupportQuestionViewModel {
  const factory SupportQuestionViewModel({
    required String questionSlug,
    @Default(null) Locale? locale,
    @Default(false) bool isLoading,
    @Default(null) Question? question,
    @Default(null) List<Question>? relatedQuestions,
    @Default(null) String? questionContent,
    String? error,
  }) = _SupportQuestionViewModel;

  const SupportQuestionViewModel._();
}
