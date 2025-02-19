import 'package:core/mocks/mock_locale_data_source.dart';
import 'package:core/repository/translation_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('TranslationRepositoryImpl', () {
    test('should translate keys for locales', () {
      var mockLocaleDataSource = MockLocaleDataSource();

      when(() => mockLocaleDataSource.fetchLocale('nl'))
          .thenAnswer((_) => mockLocaleNl);
      when(() => mockLocaleDataSource.fetchLocale('en'))
          .thenAnswer((_) => mockLocaleEn);

      var translationRepository =
          TranslationRepositoryImpl(localeDataSource: mockLocaleDataSource);
      var translationNl = translationRepository.translate('nl', 'translateMe');
      var translationEn = translationRepository.translate('en', 'translateMe');

      verify(() => mockLocaleDataSource.fetchLocale(any())).called(2);
      expect(translationNl, 'Vertaal mij');
      expect(translationEn, 'Translate me');
    });
  });
}
