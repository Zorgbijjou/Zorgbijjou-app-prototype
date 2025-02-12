import 'package:faq/faq.dart';
import 'package:mocktail/mocktail.dart';

final mockQuestions = <Question>[
  Question(
    slug: 'no-luscii-email',
    titleKey: 'noLusciiEmail',
    introductionKey: 'noLusciiEmailIntroduction',
    modifiedDate: DateTime(2024, 08, 01),
    relatedQuestions: <String, QuestionReference>{
      'is-home-measurement-free': const QuestionReference(),
    },
  ),
  Question(
    slug: 'is-home-measurement-free',
    titleKey: 'isHomeMeasurementFree',
    modifiedDate: DateTime(2024, 08, 01),
  ),
  Question(
    slug: 'can-i-stop-home-measurement',
    titleKey: 'canIStopHomeMeasurement',
    modifiedDate: DateTime(2024, 08, 01),
  ),
];

final mockFrequentlyAskedQuestions = <Question>[
  mockQuestions[0].copyWith(order: 0),
  mockQuestions[1].copyWith(order: 1),
  mockQuestions[2].copyWith(order: 2),
];

final mockQuestionContent = <String, String>{
  'nl': '''
![plaatje](images/people-at-the-door.jpeg)
Optioneel: caption

# Wacht nog 2 dagen
Lorem ipsum dolor sit amet consectetur. Venenatis sit magna varius dui amet vulputate. Hac elementum pretium sit auctor eget neque quis risus urna. Ante fringilla laoreet sit facilisi in consectetur nunc. Sit orci augue euismod convallis adipiscing.

> Blockquote: Lorem ipsum dolor sit amet consectetur. Et odio lobortis enim vel aliquet quis. Nec pretium libero non adipiscing nulla.

# Check je spam
## Check je spam
Lorem ipsum dolor sit amet consectetur. Venenatis sit magna varius dui amet vulputate. Hac elementum pretium sit auctor eget neque quis risus urna. Ante fringilla laoreet sit facilisi in consectetur nunc. Sit orci augue euismod convallis adipiscing.
## Check je spam
- Lorem ipsum dolor sit amet consectetur. Venenatis sit magna varius dui amet vulputate. 
- Hac elementum pretium sit auctor eget neque quis risus urna. 
- Ante fringilla laoreet sit facilisi in consectetur nunc. Sit orci augue euismod convallis adipiscing.

![plaatje](images/people-at-the-door.jpeg)
hoe controleer ik mijn spam in mijn email

## Neem contact met ons op
Lorem ipsum dolor sit amet consectetur. Venenatis sit magna varius dui amet vulputate. Hac elementum pretium sit auctor eget neque quis risus urna. Ante fringilla laoreet sit facilisi in consectetur nunc. Sit orci augue euismod convallis adipiscing.
''',
  'en': '''
![plaatje](images/people-at-the-door.jpeg)
optional: caption

# Wait for another 2 days
Lorem ipsum dolor sit amet consectetur. Venenatis sit magna varius dui amet vulputate. Hac elementum pretium sit auctor eget neque quis risus urna. Ante fringilla laoreet sit facilisi in consectetur nunc. Sit orci augue euismod convallis adipiscing.

> Blockquote: Lorem ipsum dolor sit amet consectetur. Et odio lobortis enim vel aliquet quis. Nec pretium libero non adipiscing nulla.

# Check your spam
## Check your spam
Lorem ipsum dolor sit amet consectetur. Venenatis sit magna varius dui amet vulputate. Hac elementum pretium sit auctor eget neque quis risus urna. Ante fringilla laoreet sit facilisi in consectetur nunc. Sit orci augue euismod convallis adipiscing.
## Check your spam
- Lorem ipsum dolor sit amet consectetur. Venenatis sit magna varius dui amet vulputate. 
- Hac elementum pretium sit auctor eget neque quis risus urna. 
- Ante fringilla laoreet sit facilisi in consectetur nunc. Sit orci augue euismod convallis adipiscing.

![plaatje](images/people-at-the-door.jpeg)
Video - how to check my spam in my mailbox

## Contact us
Lorem ipsum dolor sit amet consectetur. Venenatis sit magna varius dui amet vulputate. Hac elementum pretium sit auctor eget neque quis risus urna. Ante fringilla laoreet sit facilisi in consectetur nunc. Sit orci augue euismod convallis adipiscing.
''',
};

class MockQuestionRepository extends Mock implements QuestionRepository {
  @override
  Future<List<Question>> getFrequentlyAskedQuestions() {
    return Future.value(mockFrequentlyAskedQuestions);
  }

  @override
  Future<Question?> getQuestion(String questionSlug) {
    var question = mockQuestions.firstWhere(
      (element) => element.slug == questionSlug,
      orElse: () => Question(
        slug: questionSlug,
        titleKey: 'Unknown',
        modifiedDate: DateTime.now(),
      ),
    );

    return Future.value(question);
  }

  @override
  Future<List<Question>> getRelatedQuestions(String questionsId) {
    return Future.value(mockQuestions);
  }

  @override
  Future<String?> getQuestionContentForLocale(
      String questionSlug, String locale) {
    return Future.value(mockQuestionContent[locale]);
  }

  @override
  Future<List<Question>> getQuestionByReferenceIds(List<String> referenceIds) {
    return Future.value(mockQuestions);
  }
}

final mockQuestionRepository = MockQuestionRepository();
