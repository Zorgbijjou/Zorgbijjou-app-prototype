import '../model/question.dart';

abstract class QuestionRepository {
  Future<List<Question>> getFrequentlyAskedQuestions();
  Future<Question?> getQuestion(String questionSlug);
  Future<String?> getQuestionContentForLocale(
    String questionSlug,
    String locale,
  );

  Future<List<Question>> getQuestionByReferenceIds(List<String> referenceIds);

  Future<List<Question>> getRelatedQuestions(String questionsId);
}
