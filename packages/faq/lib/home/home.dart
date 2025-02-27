import 'package:core/core.dart';
import 'package:faq/faq.dart';
import 'package:faq/view_models/home_view_model.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:theme/theme.dart';

class Home extends StatelessWidget {
  final TranslationRepository translationRepository;
  final Function(String) onSupportQuestionClicked;
  final Function(String) onSupportSubjectClicked;
  final Locale selectedLocale;
  final Function(Locale) onLocaleChanged;
  final bool devModeEnabled;
  final VoidCallback onDevModeEnabled;
  final VoidCallback onDevButtonClick;
  final HomeViewModel homeViewModel;

  const Home({
    super.key,
    required this.translationRepository,
    required this.onSupportQuestionClicked,
    required this.onSupportSubjectClicked,
    required this.selectedLocale,
    required this.onLocaleChanged,
    required this.devModeEnabled,
    required this.onDevModeEnabled,
    required this.onDevButtonClick,
    required this.homeViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.tokens.color.tokensTurqoise800,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Container(
          color: context.tokens.color.tokensTurqoise800,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZbjPageHeader.firstLevel(
                  title: AppLocalizations.of(context)!.customerService,
                  inverted: true,
                  icon: ZbjIconWithDevModeButton(
                    icon: Icon(
                      CustomIcons.help_circle,
                      color: context.tokens.color.tokensYellow200,
                      size: 32,
                    ),
                    devModeEnabled: devModeEnabled,
                    onDevModeEnabled: onDevModeEnabled,
                    onDevButtonClick: onDevButtonClick,
                  ),
                ),
                Container(
                  color: context.tokens.color.tokensTurqoise800,
                  width: double.infinity,
                  child: ZbjGridPadding(
                    verticalPadding: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .frequentlyAskedQuestions,
                          style: context
                              .tokens.textStyle.tokensTypographyHeadingLg
                              .copyWith(
                                  color: context.tokens.color.tokensWhite),
                        ),
                        const SizedBox(height: 24),
                        homeViewModel.questions != null
                            ? _buildDividedQuestionListItemsFromQuestions(
                                context, homeViewModel.getOrderedQuestions())
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
                Container(
                  color: context.tokens.color.tokensWhite,
                  width: double.infinity,
                  child: ZbjGridPadding(
                    verticalPadding: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.questionsBySubject,
                          style: context
                              .tokens.textStyle.tokensTypographyHeadingLg,
                        ),
                        const SizedBox(height: 24),
                        homeViewModel.subjects != null
                            ? _createSubjectCardsFromSubjects(
                                context, homeViewModel.getOrderedSubjects())
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createSubjectCardsFromSubjects(
      BuildContext context, List<Subject> subjects) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: subjects.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              _createSubjectCardFromSubject(context, subjects[index]),
              const SizedBox(height: 16),
            ],
          );
        });
  }

  ZbjCard _createSubjectCardFromSubject(BuildContext context, Subject subject) {
    return ZbjCard.primary(
      title: translationRepository.translate(
          Localizations.localeOf(context).languageCode, subject.titleKey),
      subTitle:
          AppLocalizations.of(context)!.question(subject.questions.length),
      image: subject.image.isNotEmpty ? AssetImage(subject.image) : null,
      onTap: () => onSupportSubjectClicked(subject.slug),
    );
  }

  Widget _buildDividedQuestionListItemsFromQuestions(
      BuildContext context, List<Question> questions) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      separatorBuilder: (context, index) => ZbjDivider.inverted(),
      itemBuilder: (context, index) {
        var question = questions[index];

        return ZbjListItem(
          title: translationRepository.translate(
              Localizations.localeOf(context).languageCode, question.titleKey),
          position: questions.getListItemPosition(question),
          inverted: true,
          onTap: () => onSupportQuestionClicked(question.slug),
        );
      },
    );
  }
}
