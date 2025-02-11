import 'package:core/core.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:faq/repository/subject_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zorg_bij_jou/providers/support_subject_page_provider.dart';

void main() {
  group('SupportSubjectViewModelStateNotifier', () {
    var subjectRepository = MockSubjectRepository();
    var questionRepository = MockQuestionRepository();

    setUp(() {
      getIt.registerSingleton<SubjectRepository>(subjectRepository);
      getIt.registerSingleton<QuestionRepository>(questionRepository);
    });

    tearDown(() {
      getIt.reset();
    });

    var mockSubject = mockSubjects.first;

    testWidgets('Test SupportSubjectViewModelStateNotifier',
        (WidgetTester tester) async {
      var container = ProviderContainer();

      var viewModelNotifier =
          container.read(supportSubjectViewModelProvider('test').notifier);

      // Act
      await viewModelNotifier.initializeSubjectWithQuestions();

      var viewModel = container.read(supportSubjectViewModelProvider('test'));

      // Assert
      expect(viewModel.subject, mockSubject);
      expect(viewModel.questions, mockQuestions);
      expect(viewModel.subjectContent, equals(mockQuestionContent['nl']));

      // Workaround to keep auto disposed view model alive
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
