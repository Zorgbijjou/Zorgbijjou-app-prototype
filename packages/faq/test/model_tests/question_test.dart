import 'dart:convert';

import 'package:faq/faq.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Question', () {
    test('should parse JSON', () {
      var questionJson = json.decode('''
{
  "slug": "hoe-werkt-de-thuismeten-app",
  "title-key": "howDoesTheHomeMeasurementAppWork",
  "modified-date": "2024-08-01",
  "path": "assets/faq/geen-luscii-email.md",
  "related-questions": {
    "geen-luscii-email": {
      "order": 0
    }
  }
}
''');
      var question = Question.fromJson(questionJson);
      var compareQuestion = Question(
        slug: 'hoe-werkt-de-thuismeten-app',
        titleKey: 'howDoesTheHomeMeasurementAppWork',
        modifiedDate: DateTime(2024, 08, 01),
        relatedQuestions: {
          'geen-luscii-email': const QuestionReference(order: 0),
        },
      );

      expect(question, compareQuestion);
    });
  });
}
