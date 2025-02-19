import 'package:core/core.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:faq/repository/subject_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zorg_bij_jou/providers/home_page_provider.dart';

void main() {
  group('HomeViewModelStateNotifier', () {
    var questionRepository = MockQuestionRepository();
    var subjectRepository = MockSubjectRepository();

    setUp(() {
      getIt.registerSingleton<QuestionRepository>(questionRepository);
      getIt.registerSingleton<SubjectRepository>(subjectRepository);
    });

    tearDown(() {
      getIt.reset();
    });

    testWidgets('Test Initialize Subjects', (WidgetTester tester) async {
      var container = ProviderContainer();

      var viewModelNotifier = container.read(homeViewModelProvider.notifier);

      // Act
      await viewModelNotifier.initializeSubjects();

      // Assert
      var viewModel = container.read(homeViewModelProvider);
      expect(viewModel.subjects, mockSubjectsWithoutImages);

      // Workaround to keep auto disposed view model alive
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Test Initialize Frequently Asked Questions',
        (WidgetTester tester) async {
      var container = ProviderContainer();

      var viewModelNotifier = container.read(homeViewModelProvider.notifier);

      // Act
      await viewModelNotifier.initializeFrequentlyAskedQuestions();

      var viewModel = container.read(homeViewModelProvider);

      // Assert
      expect(viewModel.questions, mockFrequentlyAskedQuestions);

      // Workaround to keep auto disposed view model alive
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
