import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:faq/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' show join;

void main() {
  late Toc toc;
  late TranslationRepository translationRepository;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();

    var tocJsonString = await rootBundle.loadString('assets/faq/toc.json');
    var tocJson = json.decode(tocJsonString);

    toc = Toc.fromJson(tocJson);

    var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);
    await localeDataSource.initializeLocales(['nl', 'en']);

    translationRepository =
        TranslationRepositoryImpl(localeDataSource: localeDataSource);
  });

  group('FAQ Table of contents', () {
    test('All frequently asked questions exist', () {
      var missingQuestionIds = toc.frequentlyAskedQuestions.keys
          .where((questionId) => !toc.questions.keys.contains(questionId));
      expect(missingQuestionIds.length, isZero,
          reason: 'Missing questions: ${missingQuestionIds.join(', ')}');
    });

    test('All questions in all subjects exist', () {
      var missingQuestionIds = toc.subjects.values
          .map((subject) => subject.questions.keys
              .where((questionId) => !toc.questions.keys.contains(questionId)))
          .expand((questionId) => questionId);
      expect(missingQuestionIds.length, isZero,
          reason: 'Missing questions: ${missingQuestionIds.join(', ')}');
    });

    test('All related questions exist', () {
      for (var question in toc.questions.values) {
        var missingQuestionIds = question.relatedQuestions.keys
            .where((questionId) => !toc.questions.keys.contains(questionId));
        expect(missingQuestionIds.length, isZero,
            reason:
                'Missing from question ${question.slug}: ${missingQuestionIds.join(', ')}');
      }
    });

    test('All referenced markdown documents exist', () async {
      var questionsWithMissingDocuments =
          toc.questions.values.where((question) {
        var file = File(join('assets', 'faq', '${question.slug}-nl.md'));
        if (!file.existsSync()) {
          return true;
        }

        file = File(join('assets', 'faq', '${question.slug}-en.md'));
        return !file.existsSync();
      });
      expect(questionsWithMissingDocuments.length, isZero,
          reason:
              'Missing documents for questions: ${questionsWithMissingDocuments.map((question) => question.slug).join(', ')}');
    });
  });

  test('All translation keys are translated', () {
    var questionKeys =
        toc.questions.values.map((question) => question.titleKey);
    var questionIntroductionKeys =
        toc.questions.values.map((question) => question.introductionKey);
    var subjectKeys = toc.subjects.values.map((subject) => subject.titleKey);
    var subjectIntroductionKeys =
        toc.subjects.values.map((subject) => subject.introductionKey);

    var allKeys = [
      ...questionKeys,
      ...questionIntroductionKeys,
      ...subjectKeys,
      ...subjectIntroductionKeys,
    ];

    var missingKeys = allKeys.where((key) => key != null).cast<String>().where(
        (key) =>
            translationRepository.translate('nl', key) == key ||
            translationRepository.translate('en', key) == key);

    expect(missingKeys.length, isZero,
        reason: 'Missing translation keys: ${missingKeys.join(', ')}');
  });
}
