import 'package:core/l10n/core_localizations.dart';
import 'package:core/repository/translation_repository.dart';
import 'package:core/widgets/card.dart';
import 'package:core/widgets/label.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:theme/assets/tokens/tokens.g.dart';

import '../model/question.dart';

class RelatedQuestions extends StatelessWidget {
  final TranslationRepository translationRepository;
  final List<Question> questions;
  final Function(String) onSupportQuestionClicked;

  const RelatedQuestions({
    super.key,
    required this.questions,
    required this.translationRepository,
    required this.onSupportQuestionClicked,
  });

  @override
  Widget build(BuildContext context) {
    return questions.isEmpty
        ? const SizedBox()
        : Container(
            decoration: BoxDecoration(color: context.tokens.color.tokensWhite),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 32, left: 24, bottom: 64, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.faqMoreQuestions,
                    style: context.tokens.textStyle.tokensTypographyHeadingLg,
                  ),
                  const SizedBox(height: 16),
                  _buildQuestionList(context, questions)
                ],
              ),
            ),
          );
  }

  _buildQuestionList(BuildContext context, List<Question> questions) {
    return SizedBox(
      height: 147,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          var question = questions[index];
          return SizedBox(
            width: 256,
            child: ZbjCard.large(
              label: const ZbjLabel(label: 'Label'),
              title: translationRepository.translate(
                  Localizations.localeOf(context).languageCode,
                  question.titleKey),
              titleMaxLines: 2,
              onTap: () {
                onSupportQuestionClicked(question.slug);
              },
            ),
          );
        },
      ),
    );
  }
}
