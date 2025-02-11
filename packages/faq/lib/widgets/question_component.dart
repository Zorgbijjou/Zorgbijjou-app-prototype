import 'package:core/core.dart';
import 'package:faq/view_models/support_question_view_model.dart';
import 'package:faq/widgets/related_questions.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

import 'contact_footer.dart';

class QuestionComponent extends StatelessWidget {
  final TranslationRepository translationRepository;
  final SupportQuestionViewModel viewModel;
  final Function(String) onSupportQuestionClicked;

  const QuestionComponent({
    super.key,
    required this.viewModel,
    required this.translationRepository,
    required this.onSupportQuestionClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      backgroundColor: context.tokens.color.tokensWhite,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 24),
                    if (viewModel.question != null)
                      PageHeader.subLevel(
                        appBar: CustomAppBar(
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        title: translationRepository.translate(
                            Localizations.localeOf(context).languageCode,
                            viewModel.question!.titleKey),
                        subtitle: viewModel.question != null
                            ? AppLocalizations.of(context)!
                                .lastModified(viewModel.question!.modifiedDate)
                            : '',
                        introduction: viewModel.question!.introductionKey !=
                                null
                            ? translationRepository.translate(
                                Localizations.localeOf(context).languageCode,
                                viewModel.question!.introductionKey!)
                            : null,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 32),
                      child: viewModel.questionContent != null
                          ? Markdown(content: viewModel.questionContent ?? '')
                          : Text(AppLocalizations.of(context)!
                              .contentNotAvailable),
                    ),
                    const Expanded(child: SizedBox()),
                    ContactFooter(),
                    if (viewModel.relatedQuestions != null)
                      RelatedQuestions(
                        questions: viewModel.relatedQuestions!,
                        translationRepository: translationRepository,
                        onSupportQuestionClicked: onSupportQuestionClicked,
                      )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
