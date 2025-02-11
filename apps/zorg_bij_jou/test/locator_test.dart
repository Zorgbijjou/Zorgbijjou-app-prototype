import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source.dart';
import 'package:faq/data_source/toc_data_source.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:faq/repository/subject_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onboarding/data_source/onboarding_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zorg_bij_jou/locator.dart';

void main() {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });

  test('setupLocator registers dependencies correctly', () async {
    // Call the setupLocator function
    await setupLocator();

    // Verify that dependencies are registered in GetIt
    expect(getIt.isRegistered<TocDataSource>(), true);
    expect(getIt.isRegistered<LocaleDataSource>(), true);
    expect(getIt.isRegistered<OnboardingDataSource>(), true);
    expect(getIt.isRegistered<LocalStorage>(), true);
    expect(getIt.isRegistered<SubjectRepository>(), true);
    expect(getIt.isRegistered<QuestionRepository>(), true);
    expect(getIt.isRegistered<TranslationRepository>(), true);
    expect(getIt.isRegistered<Auth>(), true);

    // Verify that async loggers were registered
    await getIt.isReady<ZbjLogger>(instanceName: 'console');
  });
}
