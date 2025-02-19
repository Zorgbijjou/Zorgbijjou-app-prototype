import 'package:mocktail/mocktail.dart';

import '../repository/translation_repository.dart';

class MockTranslationRepository extends Mock implements TranslationRepository {
  @override
  String translate(String locale, String key) {
    return 'translated-$key';
  }
}
