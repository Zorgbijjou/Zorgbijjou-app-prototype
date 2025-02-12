import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBundle extends Mock implements AssetBundle {}

void main() {
  group('LocaleDataSourceImpl', () {
    test('should read the locale arbs', () async {
      var mockBundle = MockBundle();

      when(() => mockBundle.loadString(any()))
          .thenAnswer((_) => Future.value('{"translateMe": "Vertaal mij"}'));

      var localeDataSource = LocaleDataSourceImpl(bundle: mockBundle);
      await localeDataSource.initializeLocales(['nl']);
      await localeDataSource.initializeLocales(['en']);

      verify(() => mockBundle.loadString('packages/core/l10n/core_nl.arb'))
          .called(1);
      verify(() => mockBundle.loadString('packages/core/l10n/core_en.arb'))
          .called(1);

      var locale = localeDataSource.fetchLocale('nl');
      expect(locale['translateMe'], 'Vertaal mij');
    });
  });
}
