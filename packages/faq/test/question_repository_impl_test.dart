import 'package:faq/faq.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_toc_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('QuestionRepositoryImpl', () {
    test('should fetch frequently asked questions', () async {
      var mockTocDataSource = MockTocDataSource();

      when(() => mockTocDataSource.fetchToc())
          .thenAnswer((_) => Future.value(mockToc));

      var questionRepository =
          QuestionRepositoryImpl(tocDataSource: mockTocDataSource);
      var questions = await questionRepository.getFrequentlyAskedQuestions();

      verify(() => mockTocDataSource.fetchToc()).called(1);
      expect(questions, mockFrequentlyAskedQuestions);
    });

    test('should fetch a question', () async {
      var mockTocDataSource = MockTocDataSource();

      when(() => mockTocDataSource.fetchToc())
          .thenAnswer((_) => Future.value(mockToc));

      var questionRepository =
          QuestionRepositoryImpl(tocDataSource: mockTocDataSource);
      var question = await questionRepository.getQuestion('no-luscii-email');

      verify(() => mockTocDataSource.fetchToc()).called(1);
      expect(
          question,
          mockQuestions
              .where((question) => question.slug == 'no-luscii-email')
              .first);
    });

    test('should fetch question content', () async {
      var mockTocDataSource = MockTocDataSource();

      when(() => mockTocDataSource.fetchToc())
          .thenAnswer((_) => Future.value(mockToc));
      when(() => mockTocDataSource.fetchQuestionContent(any(), any()))
          .thenAnswer((_) => Future.value('# Pretty markdown'));

      var questionRepository =
          QuestionRepositoryImpl(tocDataSource: mockTocDataSource);
      var questionContent = await questionRepository
          .getQuestionContentForLocale('no-luscii-email', 'en');

      verify(() =>
              mockTocDataSource.fetchQuestionContent('no-luscii-email', 'en'))
          .called(1);
      expect(questionContent, '# Pretty markdown');
    });

    test('should fetch related questions', () async {
      var mockTocDataSource = MockTocDataSource();

      when(() => mockTocDataSource.fetchToc())
          .thenAnswer((_) => Future.value(mockToc));
      when(() => mockTocDataSource.fetchQuestionContent(any(), any()))
          .thenAnswer((_) => Future.value('# Pretty markdown'));

      var questionRepository =
          QuestionRepositoryImpl(tocDataSource: mockTocDataSource);
      var relatedQuestions =
          await questionRepository.getRelatedQuestions('no-luscii-email');

      expect(
          relatedQuestions,
          contains(Question(
            slug: 'is-home-measurement-free',
            titleKey: 'isHomeMeasurementFree',
            modifiedDate: DateTime(2024, 08, 01),
          )));
    });
  });
}
