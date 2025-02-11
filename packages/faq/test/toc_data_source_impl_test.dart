import 'package:faq/faq.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBundle extends Mock implements AssetBundle {}

var string = '''
{
  "frequently-asked-questions": {
    "no-luscii-email": {
      "order": 0
    },
    "is-thuismeten-gratis": {
      "order": 1
    },
    "kan-ik-stoppen-met-thuismeten": {
      "order": 2
    }
  },
  "subjects": {
    "hoe-werkt-thuismeten": {
      "slug": "hoe-werkt-thuismeten",
      "title-key": "howDoesHomeMeasurementWork",
      "order": 0,
      "image": "assets/images/beestjes.png",
      "questions": {
        "no-luscii-email": {
          "order": 0
        }
      }
    },
    "home-measurement-app": {
      "slug": "thuismeten-app",
      "title-key": "homeMeasurementApp",
      "order": 1,
      "image": "assets/images/beestjes.png"
    },
    "zorg-bij-jou-app": {
      "slug": "zorg-bij-jou-app",
      "title-key": "zorgBijJouApp",
      "order": 2,
      "image": "assets/images/telefoon.png"
    },
    "my-heart-rate-monitor": {
      "slug": "mijn-hartslagmeter",
      "title-key": "myHeartRateMonitor",
      "order": 3,
      "image": "assets/images/hartslagmeter.png"
    },
    "heart-failure": {
      "slug": "heart-failure",
      "title-key": "heartFailure",
      "order": 4,
      "image": "assets/images/beestjes.png"
    }
  },
  "questions": {
    "no-luscii-email": {
      "slug": "no-luscii-email",
      "title-key": "noLusciiEmail",
      "modified-date": "2024-08-01",
      "related-questions": {
        "hoe-werkt-de-thuismeten-app": {
          "order": 0
        }
      }
    },
    "is-thuismeten-gratis": {
      "slug": "is-thuismeten-gratis",
      "title-key": "isHomeMeasurementFree",
      "modified-date": "2024-08-01",
      "path": "assets/faq/is-thuismeten-gratis.md"
    },
    "kan-ik-stoppen-met-thuismeten": {
      "slug": "kan-ik-stoppen-met-thuismeten",
      "title-key": "canIStopHomeMeasurement",
      "modified-date": "2024-08-01",
      "path": "assets/faq/kan-ik-stoppen-met-thuismeten.md"
    }
  }
}
''';

void main() {
  group('TocDataSourceImpl', () {
    test('should read the toc configuration', () async {
      var mockBundle = MockBundle();

      when(() => mockBundle.loadString('assets/faq/toc.json'))
          .thenAnswer((_) => Future.value(string));

      var tocDataSource = TocDataSourceImpl(bundle: mockBundle);
      var toc = await tocDataSource.fetchToc();

      verify(() => mockBundle.loadString('assets/faq/toc.json')).called(1);
      expect(toc.frequentlyAskedQuestions['no-luscii-email']?.order, 0);
    });

    test('should read question content markdowns for different locales',
        () async {
      var mockBundle = MockBundle();

      when(() => mockBundle.loadString('assets/faq/no-luscii-email-nl.md',
              cache: false))
          .thenAnswer((_) => Future.value('# Pretty markdown NL'));

      when(() => mockBundle.loadString('assets/faq/no-luscii-email-en.md',
              cache: false))
          .thenAnswer((_) => Future.value('# Pretty markdown EN'));

      var tocDataSource = TocDataSourceImpl(bundle: mockBundle);
      var resultNl =
          await tocDataSource.fetchQuestionContent('no-luscii-email', 'nl');
      expect(resultNl, '# Pretty markdown NL');

      verify(() => mockBundle.loadString('assets/faq/no-luscii-email-nl.md',
          cache: false)).called(1);

      var resultEn =
          await tocDataSource.fetchQuestionContent('no-luscii-email', 'en');
      expect(resultEn, '# Pretty markdown EN');

      verify(() => mockBundle.loadString('assets/faq/no-luscii-email-en.md',
          cache: false)).called(1);
    });

    // Add a test for the fetchSubjectContent method
    test('should read subject content markdowns for different locales',
        () async {
      var mockBundle = MockBundle();

      when(() => mockBundle.loadString('assets/faq/hoe-werkt-thuismeten-nl.md',
              cache: false))
          .thenAnswer((_) => Future.value('# Pretty markdown NL'));

      when(() => mockBundle.loadString('assets/faq/hoe-werkt-thuismeten-en.md',
              cache: false))
          .thenAnswer((_) => Future.value('# Pretty markdown EN'));

      var tocDataSource = TocDataSourceImpl(bundle: mockBundle);
      var resultNl =
          await tocDataSource.fetchSubjectContent('hoe-werkt-thuismeten', 'nl');
      expect(resultNl, '# Pretty markdown NL');

      verify(() => mockBundle.loadString(
          'assets/faq/hoe-werkt-thuismeten-nl.md',
          cache: false)).called(1);

      var resultEn =
          await tocDataSource.fetchSubjectContent('hoe-werkt-thuismeten', 'en');
      expect(resultEn, '# Pretty markdown EN');

      verify(() => mockBundle.loadString(
          'assets/faq/hoe-werkt-thuismeten-en.md',
          cache: false)).called(1);
    });
  });
}
