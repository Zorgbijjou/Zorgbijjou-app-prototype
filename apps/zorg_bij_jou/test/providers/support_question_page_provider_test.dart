import 'package:core/core.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zorg_bij_jou/providers/support_question_page_provider.dart';

void main() {
  group('SupportQuestionViewModelStateNotifier', () {
    var questionRepository = MockQuestionRepository();

    setUp(() {
      getIt.registerSingleton<QuestionRepository>(questionRepository);
    });

    tearDown(() {
      getIt.reset();
    });

    testWidgets('Test SupportQuestionViewModelStateNotifier',
        (WidgetTester tester) async {
      var question = mockQuestions.elementAt(0);

      var container = ProviderContainer();

      var viewModelNotifier = container
          .read(supportQuestionViewModelProvider(question.slug).notifier);

      // Act
      await viewModelNotifier.initializeQuestionWithContent();

      var viewModel =
          container.read(supportQuestionViewModelProvider(question.slug));

      // Assert
      expect(viewModel.question, question);
      expect(viewModel.questionContent, equals(mockQuestionContent['nl']));
      expect(viewModel.relatedQuestions, equals(mockQuestions));

      // Workaround to keep auto disposed view model alive
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
