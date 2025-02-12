import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:faq/faq.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/view_models/support_question_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Question NL',
  type: QuestionComponent,
  path: 'FAQ',
)
Widget buildFaqQuestionUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);

  var translationRepository =
      TranslationRepositoryImpl(localeDataSource: localeDataSource);

  var locale = Localizations.localeOf(context);
  var mockQuestion = mockQuestions[0];

  var viewModel = SupportQuestionViewModel(
      locale: locale,
      questionSlug: mockQuestion.slug,
      question: mockQuestion,
      questionContent: mockQuestionContent[locale.languageCode],
      relatedQuestions: mockQuestions.sublist(1, 3));

  return FutureBuilder(
    future: localeDataSource.initializeLocales(['nl', 'en']),
    builder: (context, _) => QuestionComponent(
      viewModel: viewModel,
      translationRepository: translationRepository,
      onSupportQuestionClicked: (slug) {},
    ),
  );
}
