import '../data_source/toc_data_source.dart';
import '../model/subject.dart';
import 'subject_repository.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final TocDataSource tocDataSource;

  SubjectRepositoryImpl({required this.tocDataSource});

  @override
  Future<List<Subject>> getSubjects() async {
    var toc = await tocDataSource.fetchToc();

    return [...toc.subjects.values];
  }

  @override
  Future<Subject?> getSubject(String subjectSlug) async {
    var toc = await tocDataSource.fetchToc();

    var subject = toc.subjects[subjectSlug];

    return subject;
  }

  @override
  Future<String?> getSubjectContentForLocale(
      String subjectSlug, String locale) async {
    var subject = await getSubject(subjectSlug);
    if (subject == null) {
      return null;
    }

    return tocDataSource.fetchSubjectContent(subject.slug, locale);
  }
}
