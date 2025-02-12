import 'package:core/l10n/core_localizations.dart';
import 'package:core/mocks/mock_translation_repository.dart';
import 'package:core/widgets/card.dart';
import 'package:faq/model/question.dart';
import 'package:faq/widgets/related_questions.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MockFunction extends Mock {
  void call(String slug);
}

void main() {
  testWidgets('RelatedQuestions show 3 related question cards',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    List<Question> relatedQuestions = <Question>[
      Question(
        slug: 'test-related-question-slug-1',
        titleKey: 'test-related-question-title-1',
        modifiedDate: DateTime(2024, 08, 01),
      ),
      Question(
        slug: 'test-related-question-slug-1',
        titleKey: 'test-related-question-title-2',
        modifiedDate: DateTime(2024, 08, 01),
      ),
      Question(
        slug: 'test-related-question-slug-3',
        titleKey: 'test-related-question-title-3',
        modifiedDate: DateTime(2024, 08, 01),
      ),
    ];

    var mockOnSupportQuestionClicked = MockFunction();

    var testWidget = RelatedQuestions(
      questions: relatedQuestions,
      translationRepository: mockTranslationRepository,
      onSupportQuestionClicked: mockOnSupportQuestionClicked.call,
    );

    // Act
    await tester.pumpWidget(md.MaterialApp(
      home: md.Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const md.Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: testWidget,
        ),
      ),
    ));

    // Assert
    expect(find.text('translated-${relatedQuestions[0].titleKey}'),
        findsOneWidget);
    expect(find.byType(Card), findsExactly(3));
  });

  testWidgets(
      'RelatedQuestions without questions should show content is not available',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    List<Question> relatedQuestions = <Question>[];

    var mockOnSupportQuestionClicked = MockFunction();

    var testWidget = RelatedQuestions(
      questions: relatedQuestions,
      translationRepository: mockTranslationRepository,
      onSupportQuestionClicked: mockOnSupportQuestionClicked.call,
    );

    // Act
    await tester.pumpWidget(md.MaterialApp(
      home: md.Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const md.Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: testWidget,
        ),
      ),
    ));

    // Assert
    expect(find.byType(Card), findsNothing);
  });
}
