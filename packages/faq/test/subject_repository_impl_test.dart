import 'package:faq/faq.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/mocks/mock_toc_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('SubjectRepositoryImpl', () {
    test('should fetch a list of subjects', () async {
      var mockTocDataSource = MockTocDataSource();

      when(() => mockTocDataSource.fetchToc())
          .thenAnswer((_) => Future.value(mockToc));

      var subjectRepository =
          SubjectRepositoryImpl(tocDataSource: mockTocDataSource);
      var subjects = await subjectRepository.getSubjects();
      var expectSubjects = mockSubjects;

      verify(() => mockTocDataSource.fetchToc()).called(1);
      expect(subjects, expectSubjects);
    });

    test('should fetch a subject', () async {
      var mockTocDataSource = MockTocDataSource();

      when(() => mockTocDataSource.fetchToc())
          .thenAnswer((_) => Future.value(mockToc));

      var subjectRepository =
          SubjectRepositoryImpl(tocDataSource: mockTocDataSource);
      var subject =
          await subjectRepository.getSubject('how-does-home-measurement-work');
      var expectSubject = mockSubjects[0];

      verify(() => mockTocDataSource.fetchToc()).called(1);
      expect(subject, expectSubject);
    });

    // Add a test for the getSubjectContentForLocale method
    test('should fetch subject content for a locale', () async {
      var mockTocDataSource = MockTocDataSource();

      when(() => mockTocDataSource.fetchToc())
          .thenAnswer((_) => Future.value(mockToc));
      when(() => mockTocDataSource.fetchSubjectContent(any(), any()))
          .thenAnswer((_) => Future.value('# Pretty markdown'));

      var subjectRepository =
          SubjectRepositoryImpl(tocDataSource: mockTocDataSource);

      var subjectContent = await subjectRepository.getSubjectContentForLocale(
          'how-does-home-measurement-work', 'en');

      verify(() => mockTocDataSource.fetchSubjectContent(
          'how-does-home-measurement-work', 'en')).called(1);
      expect(subjectContent, '# Pretty markdown');
    });
  });
}
