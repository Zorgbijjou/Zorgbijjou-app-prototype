import '../data_source/locale_data_source.dart';
import 'translation_repository.dart';

class TranslationRepositoryImpl implements TranslationRepository {
  final LocaleDataSource localeDataSource;

  TranslationRepositoryImpl({
    required this.localeDataSource,
  });

  @override
  String translate(String locale, String key) {
    var localeJson = localeDataSource.fetchLocale(locale);

    if (!localeJson.containsKey(key) || localeJson[key] == null) {
      return key;
    }

    return localeJson[key];
  }
}
