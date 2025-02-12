import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/model/question.dart';
import 'package:faq/view_models/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeViewModel', () {
    test('default values', () {
      var viewModel = const HomeViewModel();
      expect(viewModel.locale, isNull);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.questions, isNull);
      expect(viewModel.subjects, isNull);
      expect(viewModel.error, isNull);
    });

    test('getOrderedSubjects returns sorted subjects', () {
      var unorderedMockSubjects = [
        mockSubjects[0].copyWith(order: 2),
        mockSubjects[1].copyWith(order: 0),
        mockSubjects[2].copyWith(order: 1)
      ];

      var viewModel = HomeViewModel(subjects: unorderedMockSubjects);
      var orderedSubjects = viewModel.getOrderedSubjects();

      expect(orderedSubjects[0].order, 0);
      expect(orderedSubjects[1].order, 1);
      expect(orderedSubjects[2].order, 2);
    });

    test('getOrderedQuestions returns sorted questions', () {
      var unorderedQuestions = <Question>[
        mockQuestions[0].copyWith(order: 2),
        mockQuestions[1].copyWith(order: 0),
        mockQuestions[2].copyWith(order: 1),
      ];

      var viewModel = HomeViewModel(questions: unorderedQuestions);
      var orderedQuestions = viewModel.getOrderedQuestions();

      expect(orderedQuestions[0].order, 0);
      expect(orderedQuestions[1].order, 1);
      expect(orderedQuestions[2].order, 2);
    });

    test('error handling', () {
      var viewModel = const HomeViewModel(error: 'An error occurred');
      expect(viewModel.error, 'An error occurred');
    });
  });
}
