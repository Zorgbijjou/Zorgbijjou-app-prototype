import 'package:core/core.dart';
import 'package:core/mocks/mock_translation_repository.dart';
import 'package:faq/home/home.dart';
import 'package:faq/mocks/mock_question_repository.dart';
import 'package:faq/mocks/mock_subject_repository.dart';
import 'package:faq/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/theme.dart';

class MockLocalizationDelegate extends Mock
    implements LocalizationsDelegate<WidgetsLocalizations> {}

void main() {
  group('FAQ home component', () {
    testWidgets('Should render frequently asked questions and subjects',
        (tester) async {
      var translationRepository = MockTranslationRepository();

      var homeViewModel = HomeViewModel(
        subjects: mockSubjectsWithoutImages,
        questions: mockFrequentlyAskedQuestions,
      );

      await tester.pumpWidget(Tokens(
          tokens: DefaultTokens(),
          child: Localizations(
              delegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              locale: const Locale('nl'),
              child: Home(
                homeViewModel: homeViewModel,
                translationRepository: translationRepository,
                onSupportQuestionClicked: (_) {},
                onSupportSubjectClicked: (_) {},
                selectedLocale: const Locale('nl'),
                onLocaleChanged: (_) {},
                onDevButtonClick: () {},
                devModeEnabled: false,
                onDevModeEnabled: () {},
              ))));
      await tester.pumpAndSettle();

      var subjectFinder = find.text('translated-homeMeasurementApp');
      var questionFinder = find.text('translated-isHomeMeasurementFree');

      expect(subjectFinder, findsOneWidget);
      expect(questionFinder, findsOneWidget);
    });

    testWidgets('Should enable dev mode after 5 clicks on dev mode icon',
        (tester) async {
      var translationRepository = MockTranslationRepository();

      var homeViewModel = HomeViewModel(
        subjects: mockSubjectsWithoutImages,
        questions: mockFrequentlyAskedQuestions,
      );

      var devModeEnabled = false;

      await tester.pumpWidget(Tokens(
          tokens: DefaultTokens(),
          child: Localizations(
              delegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              locale: const Locale('nl'),
              child: Home(
                homeViewModel: homeViewModel,
                translationRepository: translationRepository,
                onSupportQuestionClicked: (_) {},
                onSupportSubjectClicked: (_) {},
                selectedLocale: const Locale('nl'),
                onLocaleChanged: (_) {},
                onDevButtonClick: () {},
                devModeEnabled: devModeEnabled,
                onDevModeEnabled: () {
                  devModeEnabled = true;
                },
              ))));
      await tester.pumpAndSettle();

      var devModeIconFinder = find.byType(IconWithDevModeButton);

      for (var i = 0; i < 5; i++) {
        await tester.tap(devModeIconFinder);
        await tester.pumpAndSettle();
      }

      expect(devModeEnabled, isTrue);
    });

    testWidgets('Should show dev mode button when dev mode is enabled',
        (tester) async {
      var translationRepository = MockTranslationRepository();

      var homeViewModel = HomeViewModel(
        subjects: mockSubjectsWithoutImages,
        questions: mockFrequentlyAskedQuestions,
      );

      await tester.pumpWidget(Tokens(
          tokens: DefaultTokens(),
          child: Localizations(
              delegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              locale: const Locale('nl'),
              child: Home(
                homeViewModel: homeViewModel,
                translationRepository: translationRepository,
                onSupportQuestionClicked: (_) {},
                onSupportSubjectClicked: (_) {},
                selectedLocale: const Locale('nl'),
                onLocaleChanged: (_) {},
                onDevButtonClick: () {},
                devModeEnabled: true,
                onDevModeEnabled: () {},
              ))));
      await tester.pumpAndSettle();

      var devModeButtonFinder = find.text('DEV');

      expect(devModeButtonFinder, findsOneWidget);
    });
  });
}
