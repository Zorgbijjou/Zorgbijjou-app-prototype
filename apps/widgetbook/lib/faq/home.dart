import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:faq/faq.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Home',
  type: Home,
  path: 'FAQ',
)
Widget buildFaqHomeUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);

  var translationRepository =
      TranslationRepositoryImpl(localeDataSource: localeDataSource);

  var homeViewModel = HomeViewModel(
    subjects: mockSubjects,
    questions: mockFrequentlyAskedQuestions,
  );

  var locale = Localizations.localeOf(context);

  return FutureBuilder(
    future: localeDataSource.initializeLocales(['nl', 'en']),
    builder: (context, _) => Home(
      homeViewModel: homeViewModel,
      translationRepository: translationRepository,
      onSupportQuestionClicked: (String label) {},
      onSupportSubjectClicked: (String label) {},
      selectedLocale: locale,
      onLocaleChanged: (Locale locale) {},
      onDevButtonClick: () {},
      devModeEnabled: false,
      onDevModeEnabled: () {},
    ),
  );
}
