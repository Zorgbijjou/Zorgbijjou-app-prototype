import 'dart:ui';

import 'package:faq/faq.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_subject_view_model.freezed.dart';

@freezed
class SupportSubjectViewModel with _$SupportSubjectViewModel {
  const factory SupportSubjectViewModel({
    required String subjectSlug,
    @Default(null) Locale? locale,
    @Default(false) bool isLoading,
    @Default(null) Subject? subject,
    @Default(null) String? subjectContent,
    @Default(null) List<Question>? questions,
    String? error,
  }) = _SupportSubjectViewModel;

  const SupportSubjectViewModel._();
}
