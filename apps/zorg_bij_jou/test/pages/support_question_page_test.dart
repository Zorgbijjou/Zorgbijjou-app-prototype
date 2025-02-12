import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/repository/question_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:zorg_bij_jou/pages/support_question_page.dart';
import 'package:zorg_bij_jou/providers/support_question_page_provider.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

void main() {
  testWidgets('SupportQuestionPage test', (WidgetTester tester) async {
    var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);
    await localeDataSource.initializeLocales([
      'nl',
      'en',
    ]);
    initializeDateFormatting();
    getIt.registerSingleton<LocaleDataSource>(localeDataSource);

    getIt.registerSingleton<TranslationRepository>(
        TranslationRepositoryImpl(localeDataSource: getIt()));

    var mockQuestionRepository = MockQuestionRepository();
    getIt.registerSingleton<QuestionRepository>(mockQuestionRepository);

    var container = ProviderContainer();
    container.read(supportQuestionViewModelProvider('test-slug').notifier);

    // Act
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Tokens(
          tokens: DefaultTokens(),
          child: MaterialApp.router(
            routerConfig: GoRouter(
                initialLocation:
                    '/$supportHome/$supportQuestionRoute/test-slug',
                routes: [
                  GoRoute(
                    path: '/$supportHome/$supportQuestionRoute/:questionSlug',
                    builder: (context, state) {
                      var slug = state.pathParameters['questionSlug'];

                      if (slug == null) {
                        throw Exception();
                      }

                      return SupportQuestionPage(slug: slug);
                    },
                  ),
                ]),
            localizationsDelegates: const [
              AppLocalizations.delegate,
            ],
          ),
        ),
      ),
    );

    // pump
    await tester.pumpAndSettle();

    expect(find.text('I have not received an e-mail from Luscii, now what?'),
        findsExactly(1));

    // Verify related question
    expect(
        find.text('Is home measurement by Zorg bij jou free?'), findsOneWidget);
    tester
        .ensureVisible(find.text('Is home measurement by Zorg bij jou free?'));

    await tester.tap(find.text('Is home measurement by Zorg bij jou free?'));

    await tester.pumpAndSettle();

    expect(find.text('Is home measurement by Zorg bij jou free?'),
        findsExactly(2));
  });
}
