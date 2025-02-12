import 'package:mocktail/mocktail.dart';

import '../model/question_reference.dart';
import '../model/subject.dart';
import '../repository/subject_repository.dart';

final questionRefs = ['question-1', 'question-2', 'question-3'];

final mockSubjects = <Subject>[
  Subject(
    slug: 'how-does-home-measurement-work',
    titleKey: 'howDoesHomeMeasurementWork',
    introductionKey: 'howDoesHomeMeasurementWorkIntroduction',
    order: 0,
    image: 'assets/images/beestjes.png',
    questions: {
      questionRefs[0]: const QuestionReference(order: 1),
      questionRefs[1]: const QuestionReference(order: 0),
    },
  ),
  Subject(
    slug: 'home-measurement-app',
    titleKey: 'homeMeasurementApp',
    order: 1,
    image: 'assets/images/telefoon.png',
    questions: {
      questionRefs[1]: const QuestionReference(order: 0),
    },
  ),
  Subject(
    slug: 'zorg-bij-jou-app',
    titleKey: 'zorgBijJouApp',
    order: 2,
    image: 'assets/images/telefoon.png',
    questions: {
      questionRefs[0]: const QuestionReference(order: 0),
      questionRefs[1]: const QuestionReference(order: 2),
      questionRefs[2]: const QuestionReference(order: 1),
    },
  ),
  const Subject(
    slug: 'my-heart-rate-monitor',
    titleKey: 'myHeartRateMonitor',
    order: 2,
    image: 'assets/images/hartslagmeter.png',
  ),
  Subject(
    slug: 'heart-failure',
    titleKey: 'heartFailure',
    order: 2,
    image: 'assets/images/beestjes.png',
    questions: {
      questionRefs[0]: const QuestionReference(order: 0),
      questionRefs[1]: const QuestionReference(order: 2),
      questionRefs[2]: const QuestionReference(order: 1),
    },
  ),
];
final mockSubjectsWithoutImages =
    mockSubjects.map((subject) => subject.copyWith(image: '')).toList();

final mockSubjectContent = <String, String>{
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

class MockSubjectRepository extends Mock implements SubjectRepository {
  @override
  Future<List<Subject>> getSubjects() {
    return Future.value(mockSubjectsWithoutImages);
  }

  @override
  Future<Subject?> getSubject(String subjectSlug) {
    var subject = mockSubjects.elementAt(0);
    return Future.value(subject);
  }

  @override
  Future<String?> getSubjectContentForLocale(
      String subjectSlug, String locale) {
    return Future.value(mockSubjectContent[locale]);
  }
}

final mockSubjectRepository = MockSubjectRepository();
