import 'package:core/core.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:faq/view_models/support_question_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zorg_bij_jou/providers/locale_provider.dart';
import 'package:zorg_bij_jou/providers/provider_extensions.dart';

final supportQuestionViewModelProvider = StateNotifierProvider.family<
        SupportQuestionViewModelStateNotifier,
        SupportQuestionViewModel,
        String>(
    (ref, questionSlug) =>
        SupportQuestionViewModelStateNotifier(ref, questionSlug));

class SupportQuestionViewModelStateNotifier
    extends StateNotifier<SupportQuestionViewModel> {
  final Ref _ref;
  final QuestionRepository questionRepository = getIt();

  SupportQuestionViewModelStateNotifier(this._ref, String questionSlug)
      : super(SupportQuestionViewModel(questionSlug: questionSlug)) {
    _ref.readAndListenStateProvider(localeProvider, updateLocale);
  }

  void updateLocale(Locale locale) {
    state = state.copyWith(
      locale: locale,
    );
  }

  Future initializeQuestionWithContent() async {
    var questionFuture = questionRepository.getQuestion(state.questionSlug);
    var relatedQuestionFuture =
        questionRepository.getRelatedQuestions(state.questionSlug);

    var questionContentFuture = questionRepository.getQuestionContentForLocale(
        state.questionSlug, state.locale?.languageCode ?? '');

    var (question, questionContent, relatedQuestions) = await (
      questionFuture,
      questionContentFuture,
      relatedQuestionFuture
    ).wait;

    state = state.copyWith(
        question: question,
        questionContent: questionContent,
        relatedQuestions: relatedQuestions);
  }
}
