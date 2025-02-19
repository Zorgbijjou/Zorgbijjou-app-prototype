import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:faq/faq.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/view_models/support_subject_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Subject',
  type: SubjectComponent,
  path: 'FAQ',
)
Widget buildFaqSubjectUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);

  var translationRepository =
      TranslationRepositoryImpl(localeDataSource: localeDataSource);

  var viewModel = SupportSubjectViewModel(
      subjectSlug: mockSubjects.first.slug,
      subject: mockSubjects.first,
      questions: mockQuestions);

  return FutureBuilder(
      future: localeDataSource.initializeLocales(['nl', 'en']),
      builder: (context, _) => SubjectComponent(
            viewModel: viewModel,
            translationRepository: translationRepository,
            onSupportQuestionClicked: (slug) {},
          ));
}
