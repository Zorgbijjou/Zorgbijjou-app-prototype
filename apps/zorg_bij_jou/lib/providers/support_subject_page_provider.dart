import 'package:core/core.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:faq/repository/subject_repository.dart';
import 'package:faq/view_models/support_subject_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zorg_bij_jou/providers/locale_provider.dart';
import 'package:zorg_bij_jou/providers/provider_extensions.dart';

final supportSubjectViewModelProvider = StateNotifierProvider.family<
        SupportSubjectViewModelStateNotifier, SupportSubjectViewModel, String>(
    (ref, subjectSlug) =>
        SupportSubjectViewModelStateNotifier(ref, subjectSlug));

class SupportSubjectViewModelStateNotifier
    extends StateNotifier<SupportSubjectViewModel> {
  final Ref _ref;
  final SubjectRepository subjectRepository = getIt();
  final QuestionRepository questionRepository = getIt();

  SupportSubjectViewModelStateNotifier(this._ref, String subjectSlug)
      : super(SupportSubjectViewModel(subjectSlug: subjectSlug)) {
    _ref.readAndListenStateProvider(localeProvider, updateLocale);
  }

  void updateLocale(Locale locale) {
    state = state.copyWith(
      locale: locale,
    );
  }

  Future initializeSubjectWithQuestions() async {
    var subject = await subjectRepository.getSubject(state.subjectSlug);

    if (subject == null) {
      return;
    }

    var subjectContentFuture = subjectRepository.getSubjectContentForLocale(
        state.subjectSlug, state.locale?.languageCode ?? '');

    var questionReferenceIds =
        subject.questions.entries.map((e) => e.key).toList();

    var questionsFuture =
        questionRepository.getQuestionByReferenceIds(questionReferenceIds);

    var (subjectContent, questions) = await (
      subjectContentFuture,
      questionsFuture,
    ).wait;

    state = state.copyWith(
      subject: subject,
      questions: questions,
      subjectContent: subjectContent,
    );
  }
}
