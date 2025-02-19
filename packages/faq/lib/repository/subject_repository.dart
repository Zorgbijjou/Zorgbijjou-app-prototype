import '../model/subject.dart';

abstract class SubjectRepository {
  Future<List<Subject>> getSubjects();

  Future<Subject?> getSubject(String subjectSlug);

  Future<String?> getSubjectContentForLocale(
    String subjectSlug,
    String locale,
  );
}
