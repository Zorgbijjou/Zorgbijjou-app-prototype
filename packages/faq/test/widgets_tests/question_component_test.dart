import 'package:core/l10n/core_localizations.dart';
import 'package:core/mocks/mock_translation_repository.dart';
import 'package:core/widgets/card.dart';
import 'package:faq/model/question.dart';
import 'package:faq/view_models/support_question_view_model.dart';
import 'package:faq/widgets/contact_footer.dart';
import 'package:faq/widgets/question_component.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MockFunction extends Mock {
  void call(String slug);
}

void main() {
  testWidgets('QuestionComponent displays questions correctly',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var question = Question(
      slug: 'test-question-slug',
      titleKey: 'test-question-title',
      introductionKey: 'test-question-intro',
      modifiedDate: DateTime(2024, 08, 01),
    );

    var mockViewModel =
        SupportQuestionViewModel(questionSlug: 'test-slug', question: question);

    var mockOnSupportQuestionClicked = MockFunction();
    // Act
    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: QuestionComponent(
            viewModel: mockViewModel,
            translationRepository: mockTranslationRepository,
            onSupportQuestionClicked: mockOnSupportQuestionClicked.call,
          ),
        ),
      ),
    ));

    // Assert
    expect(find.text('translated-${question.titleKey}'), findsOneWidget);
    expect(find.text('translated-${question.introductionKey}'), findsOneWidget);
  });

  testWidgets('QuestionComponent should contain the contact footer',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var mockViewModel = SupportQuestionViewModel(
        questionSlug: 'test-slug',
        question: Question(
          slug: 'test-question-slug',
          titleKey: 'test-question-title',
          modifiedDate: DateTime(2024, 08, 01),
        ));

    var mockOnSupportQuestionClicked = MockFunction();

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: QuestionComponent(
            viewModel: mockViewModel,
            translationRepository: mockTranslationRepository,
            onSupportQuestionClicked: mockOnSupportQuestionClicked.call,
          ),
        ),
      ),
    ));

    // Assert
    expect(find.byType(ContactFooter), findsOneWidget);
  });

  testWidgets('QuestionComponent should show related questions',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var question = Question(
      slug: 'test-question-slug',
      titleKey: 'test-question-title',
      modifiedDate: DateTime(2024, 08, 01),
    );

    List<Question> relatedQuestions = <Question>[
      Question(
        slug: 'test-related-question-slug',
        titleKey: 'title',
        modifiedDate: DateTime(2024, 08, 01),
      )
    ];

    var mockViewModel = SupportQuestionViewModel(
        questionSlug: 'test-slug',
        question: question,
        relatedQuestions: relatedQuestions);

    var mockOnSupportQuestionClicked = MockFunction();
    // Act
    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: QuestionComponent(
            viewModel: mockViewModel,
            translationRepository: mockTranslationRepository,
            onSupportQuestionClicked: mockOnSupportQuestionClicked.call,
          ),
        ),
      ),
    ));

    // Assert
    expect(find.text('translated-${question.titleKey}'), findsOneWidget);
    expect(find.byType(ZbjCard), findsOneWidget);
  });
}
