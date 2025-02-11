import 'package:core/data_source/locale_data_source.dart';
import 'package:mocktail/mocktail.dart';

final Map<String, dynamic> mockLocaleNl = {
  'translateMe': 'Vertaal mij',
};

final Map<String, dynamic> mockLocaleEn = {
  'translateMe': 'Translate me',
};

class MockLocaleDataSource extends Mock implements LocaleDataSource {}
