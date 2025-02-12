import 'package:faq/faq.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:mocktail/mocktail.dart';

final mockToc = Toc(
  frequentlyAskedQuestions: Map.fromEntries(mockQuestions.map((question) =>
      MapEntry(question.slug,
          QuestionReference(order: mockQuestions.indexOf(question))))),
  subjects: Map.fromEntries(
      mockSubjects.map((subject) => MapEntry(subject.slug, subject))),
  questions: Map.fromEntries(
      mockQuestions.map((question) => MapEntry(question.slug, question))),
);

class MockTocDataSource extends Mock implements TocDataSource {}

final mockTocDataSource = MockTocDataSource();
