import '../model/toc.dart';

abstract class TocDataSource {
  Future<Toc> fetchToc();
  Future<String> fetchQuestionContent(String questionSlug, String locale);
  Future<String> fetchSubjectContent(String subjectSlug, String locale);
}
