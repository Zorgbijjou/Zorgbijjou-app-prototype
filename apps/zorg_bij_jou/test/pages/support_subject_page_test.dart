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
import 'package:zorg_bij_jou/pages/support_subject_page.dart';
import 'package:zorg_bij_jou/providers/support_subject_page_provider.dart';

void main() {
  testWidgets('SupportSubjectPage test', (WidgetTester tester) async {
    var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);
    await localeDataSource.initializeLocales([
      'nl',
      'en',
    ]);
    getIt.registerSingleton<LocaleDataSource>(localeDataSource);

    getIt.registerSingleton<TranslationRepository>(
        TranslationRepositoryImpl(localeDataSource: getIt()));

    var mockSubjectRepository = MockSubjectRepository();
    getIt.registerSingleton<SubjectRepository>(mockSubjectRepository);

    var mockQuestionRepository = MockQuestionRepository();
    getIt.registerSingleton<QuestionRepository>(mockQuestionRepository);

    var container = ProviderContainer();
    container.read(supportSubjectViewModelProvider('test-slug').notifier);

    // Act
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Tokens(
          tokens: DefaultTokens(),
          child: const MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
            ],
            home: SupportSubjectPage(slug: 'test-slug'),
          ),
        ),
      ),
    );

    // pump
    await tester.pumpAndSettle();

    // Verify text on screen
    expect(find.text('I have not received an e-mail from Luscii, now what?'),
        findsOneWidget);

    // verify subject content
    expect(
        find.text(
            'Lorem ipsum dolor sit amet consectetur. Venenatis sit magna varius dui amet vulputate.'),
        findsOneWidget);

    expect(find.text('How does home measurement work'), findsOneWidget);
  });
}
