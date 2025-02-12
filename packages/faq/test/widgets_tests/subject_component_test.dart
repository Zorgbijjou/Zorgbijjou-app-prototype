import 'package:core/l10n/core_localizations.dart';
import 'package:core/mocks/mock_translation_repository.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/view_models/support_subject_view_model.dart';
import 'package:faq/widgets/contact_footer.dart';
import 'package:faq/widgets/subject_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class MockFunction extends Mock {
  void call(String slug);
}

void main() {
  testWidgets('SubjectComponent displays questions correctly',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var questions = mockQuestions;
    var subject = mockSubjects.first;

    var mockViewModel = SupportSubjectViewModel(
        subjectSlug: 'test-slug', questions: questions, subject: subject);

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
          child: SubjectComponent(
            viewModel: mockViewModel,
            translationRepository: mockTranslationRepository,
            onSupportQuestionClicked: (slug) {},
          ),
        ),
      ),
    ));

    // Assert
    expect(find.text('translated-${subject.titleKey}'), findsOneWidget);
    expect(find.text('translated-${subject.introductionKey}'), findsOneWidget);
    expect(find.text('translated-${questions.first.titleKey}'), findsOneWidget);
  });

  testWidgets(
      'SubjectComponent calls onSupportQuestionClicked when a question is tapped',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var questions = mockQuestions;
    var subject = mockSubjects.first;

    var mockViewModel = SupportSubjectViewModel(
        subjectSlug: 'test-slug', questions: questions, subject: subject);

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
          child: SubjectComponent(
            viewModel: mockViewModel,
            translationRepository: mockTranslationRepository,
            onSupportQuestionClicked: mockOnSupportQuestionClicked.call,
          ),
        ),
      ),
    ));

    // Simulate a tap on the first question
    await tester.tap(find.text('translated-${questions.first.titleKey}'));
    await tester.pump();

    // Assert
    verify(() => mockOnSupportQuestionClicked(questions.first.slug)).called(1);
  });

  testWidgets('SubjectComponent should contain the contact footer',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var questions = mockQuestions;
    var subject = mockSubjects.first;

    var mockViewModel = SupportSubjectViewModel(
        subjectSlug: 'test-slug', questions: questions, subject: subject);

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
          child: SubjectComponent(
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
}
