import 'package:core/core.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:faq/repository/subject_repository.dart';
import 'package:faq/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zorg_bij_jou/providers/locale_provider.dart';
import 'package:zorg_bij_jou/providers/provider_extensions.dart';

final homeViewModelProvider = StateNotifierProvider.autoDispose<
    HomeViewModelStateNotifier,
    HomeViewModel>((ref) => HomeViewModelStateNotifier(ref));

class HomeViewModelStateNotifier extends StateNotifier<HomeViewModel> {
  final Ref _ref;
  final QuestionRepository questionRepository = getIt();
  final SubjectRepository subjectRepository = getIt();

  HomeViewModelStateNotifier(this._ref) : super(const HomeViewModel()) {
    _ref.readAndListenStateProvider(localeProvider, updateLocale);
  }

  void updateLocale(Locale locale) {
    state = state.copyWith(
      locale: locale,
    );
  }

  Future initializeFrequentlyAskedQuestions() async {
    var frequentlyAskedQuestions =
        await questionRepository.getFrequentlyAskedQuestions();

    state = state.copyWith(questions: frequentlyAskedQuestions);
  }

  Future initializeSubjects() async {
    var subjects = await subjectRepository.getSubjects();

    state = state.copyWith(subjects: subjects);
  }
}
