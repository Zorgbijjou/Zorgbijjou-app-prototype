import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:faq/repository/subject_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:zorg_bij_jou/pages/home_page.dart';
import 'package:zorg_bij_jou/providers/home_page_provider.dart';

void main() {
  group('HomePage should contain text:', () {
    ProviderContainer? container;

    var localesExpectedText = {
      'en': [
        'Is home measurement by Zorg bij jou free?',
        'How does home measurement work'
      ],
      'nl': ['Is thuismeten van Zorg bij jou gratis?', 'Hoe werkt thuismeten?'],
    };

    setUp(() {
      container = setupMainMock();
    });

    tearDown(() {
      getIt.reset();
    });

    localesExpectedText.forEach((locale, expected) {
      testWidgets('Locale: $locale should contain: $expected',
          (WidgetTester tester) async {
        // Act
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container!,
            child: Tokens(
              tokens: DefaultTokens(),
              child: MaterialApp(
                locale: Locale(locale),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const HomePage(),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify text on screen
        for (var expectedText in expected) {
          expect(find.text(expectedText), findsOneWidget);
        }
      });
    });
  });
}

ProviderContainer setupMainMock() {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);
  localeDataSource.initializeLocales([
    'nl',
    'en',
  ]);

  getIt.registerSingleton<LocaleDataSource>(localeDataSource);

  getIt.registerSingleton<TranslationRepository>(
      TranslationRepositoryImpl(localeDataSource: getIt()));

  var mockQuestionRepository = MockQuestionRepository();
  getIt.registerSingleton<QuestionRepository>(mockQuestionRepository);

  var subjectRepository = MockSubjectRepository();
  getIt.registerSingleton<SubjectRepository>(subjectRepository);

  var mockLocalStorage = MockLocalStorage();
  getIt.registerSingleton<LocalStorage>(mockLocalStorage);

  var container = ProviderContainer();
  container.read(homeViewModelProvider.notifier);
  return container;
}
