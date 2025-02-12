import 'dart:convert';

import 'package:faq/faq.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Toc', () {
    test('should parse JSON', () {
      var tocJson = json.decode('''
{
  "frequently-asked-questions": {
    "geen-luscii-email": {
      "order": 0
    }    
  },
  "subjects": {
    "hoe-werkt-thuismeten": {
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
  },
  "questions": {
    "geen-luscii-email": {
      "slug": "geen-luscii-email",
      "title-key": "noLusciiEmail",
      "modified-date": "2024-08-01",
      "path": "assets/faq/geen-luscii-email.md",
      "related-questions": {
        "hoe-werkt-de-thuismeten-app": {
          "order": 0
        }
      }
    }
  }
}
''');
      var toc = Toc.fromJson(tocJson);
      var compareToc = Toc(frequentlyAskedQuestions: {
        'geen-luscii-email': const QuestionReference(order: 0)
      }, subjects: {
        'hoe-werkt-thuismeten': const Subject(
            slug: 'hoe-werkt-thuismeten',
            titleKey: 'howDoesHomeMeasurementWork',
            order: 0,
            image: 'assets/images/beestjes.png',
            questions: {'geen-luscii-email': QuestionReference(order: 0)})
      }, questions: {
        'geen-luscii-email': Question(
            slug: 'geen-luscii-email',
            titleKey: 'noLusciiEmail',
            modifiedDate: DateTime(2024, 08, 01),
            relatedQuestions: {
              'hoe-werkt-de-thuismeten-app': const QuestionReference(order: 0)
            })
      });

      expect(toc, compareToc);
    });
  });
}
