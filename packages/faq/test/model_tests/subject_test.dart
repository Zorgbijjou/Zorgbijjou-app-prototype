import 'dart:convert';

import 'package:faq/faq.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Subject', () {
    test('should parse JSON', () {
      var subjectJson = json.decode('''
{
  "slug": "hoe-werkt-thuismeten",
  "title-key": "howDoesHomeMeasurementWork",
  "order": 0,
  "image": "assets/images/beestjes.png",
  "questions": {
    "geen-luscii-email": {
      "order": 0
    }
  }
}
''');
      var subject = Subject.fromJson(subjectJson);
      var compareSubject = const Subject(
          slug: 'hoe-werkt-thuismeten',
          titleKey: 'howDoesHomeMeasurementWork',
          order: 0,
          image: 'assets/images/beestjes.png',
          questions: {'geen-luscii-email': QuestionReference(order: 0)});

      expect(subject, compareSubject);
    });

    test('should parse JSON with empty questions', () {
      var subjectJson = json.decode('''
{
  "slug": "hoe-werkt-thuismeten",
  "title-key": "howDoesHomeMeasurementWork",  
  "order": 0,
  "image": "assets/images/beestjes.png"
}
''');
      var subject = Subject.fromJson(subjectJson);
      var compareSubject = const Subject(
          slug: 'hoe-werkt-thuismeten',
          titleKey: 'howDoesHomeMeasurementWork',
          order: 0,
          image: 'assets/images/beestjes.png',
          questions: {});

      expect(subject, compareSubject);
    });
  });
}
