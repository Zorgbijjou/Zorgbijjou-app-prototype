import 'dart:convert';

import 'package:faq/faq.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuestionReference', () {
    test('should parse JSON', () {
      var questionReferenceJson = json.decode('''
{
  "order": 0
}
''');
      var questionReference = QuestionReference.fromJson(questionReferenceJson);
      var compareQuestionReference = const QuestionReference(
        order: 0,
      );

      expect(questionReference, compareQuestionReference);
    });
  });
}
