import '../data_source/toc_data_source.dart';
import '../model/question.dart';
import 'question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final TocDataSource tocDataSource;

  QuestionRepositoryImpl({
    required this.tocDataSource,
  });

  @override
  Future<List<Question>> getFrequentlyAskedQuestions() async {
    var toc = await tocDataSource.fetchToc();
    var questions = toc.frequentlyAskedQuestions.entries
        .map((entry) =>
            toc.questions[entry.key]?.copyWith(order: entry.value.order))
        .nonNulls
        .toList();

    return questions;
  }

  @override
  Future<Question?> getQuestion(String questionSlug) async {
    var toc = await tocDataSource.fetchToc();
    var question = toc.questions[questionSlug];

    return question;
  }

  @override
  Future<String?> getQuestionContentForLocale(
      String questionSlug, String locale) async {
    var question = await getQuestion(questionSlug);
    if (question == null) {
      return null;
    }

    return tocDataSource.fetchQuestionContent(questionSlug, locale);
  }

  @override
  Future<List<Question>> getQuestionByReferenceIds(
      List<String> referenceIds) async {
    var toc = await tocDataSource.fetchToc();

    var questions = referenceIds
        .map((referenceId) => toc.questions[referenceId])
        .nonNulls
        .toList();

    return questions;
  }

  @override
  Future<List<Question>> getRelatedQuestions(String questionsSlug) async {
    var toc = await tocDataSource.fetchToc();

    var question = toc.questions[questionsSlug] as Question;
    var relatedQuestionKeys = question.relatedQuestions.keys;

    return relatedQuestionKeys
        .map((relatedQuestionSlug) => toc.questions[relatedQuestionSlug])
        .nonNulls
        .toList();
  }
}
