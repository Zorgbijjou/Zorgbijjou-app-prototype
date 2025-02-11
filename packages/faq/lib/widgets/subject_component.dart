import 'package:core/core.dart';
import 'package:faq/model/question.dart';
import 'package:faq/view_models/support_subject_view_model.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

import 'contact_footer.dart';

class SubjectComponent extends StatelessWidget {
  final TranslationRepository translationRepository;
  final SupportSubjectViewModel viewModel;
  final Function(String) onSupportQuestionClicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      backgroundColor: context.tokens.color.tokensWhite,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 24),
                    if (viewModel.subject != null)
                      PageHeader.subLevel(
                        appBar: CustomAppBar(
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        title: translationRepository.translate(
                            Localizations.localeOf(context).languageCode,
                            viewModel.subject!.titleKey),
                        introduction: viewModel.subject!.introductionKey != null
                            ? translationRepository.translate(
                                Localizations.localeOf(context).languageCode,
                                viewModel.subject!.introductionKey!)
                            : null,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 32),
                      child: viewModel.subjectContent != null
                          ? Markdown(content: viewModel.subjectContent ?? '')
                          : Text(AppLocalizations.of(context)!
                              .contentNotAvailable),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 32),
                      child: viewModel.questions != null
                          ? _buildQuestionList(context, viewModel.questions!)
                          : Text(AppLocalizations.of(context)!
                              .contentNotAvailable),
                    ),
                    const Expanded(child: SizedBox()),
                    ContactFooter(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  const SubjectComponent({
    super.key,
    required this.viewModel,
    required this.translationRepository,
    required this.onSupportQuestionClicked,
  });

  _buildQuestionList(BuildContext context, List<Question> questions) {
    List<Widget> children = [];

    for (int index = 0; index < questions.length; index++) {
      if (index > 0) {
        children.add(CustomDivider.standard());
      }

      var question = questions[index];

      ListItem item = ListItem(
        title: translationRepository.translate(
            Localizations.localeOf(context).languageCode, question.titleKey),
        position: questions.getListItemPosition(question),
        onTap: () {
          onSupportQuestionClicked(question.slug);
        },
      );

      children.add(item);
    }

    return Column(children: children);
  }
}
