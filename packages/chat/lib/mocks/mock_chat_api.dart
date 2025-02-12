import 'package:chat/data_source/chat_data_source.dart';
import 'package:chat/models/conversation.dart';
import 'package:chat/models/conversation_messages.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/message_summary.dart';
import 'package:chat/models/user.dart';
import 'package:mocktail/mocktail.dart';

final mockConversation = mockConversations['123']![0];
const verpleegkundigenWelcomeMessage =
    'In deze chat kan je alle vragen stellen die je hebt rondom het gebruik van deze app en nog meer dingen.';
const loremIpsum =
    'Lorem ipsum dolor sit amet consectetur. Eu dictumst quam vestibulum felis risus ultrices massa adipiscing. Massa nec gravida non vulputate eget id. Lorem ipsum dolor sit amet consectetur.';
const planVisitMessage = 'We plannen een bezoek voor u in met de poli';
const systemNotAvailable =
    'Helaas kunnen wij niet meer reageren op uw bericht. U kunt ons bereiken via de telefoon of mail. Neem contact op met Zorgbijjou voor meer informatie.';

final mockConversations = {
  '123': [
    Conversation(
      id: '1',
      practitioner: 'Zorgbijjou',
      lastMessage: MessageSummary(
        text:
            'Welkom bij de app van Zorgbijjou. Je kan hier terecht voor al je vragen over de app en je zorgtraject. Hoe ',
        sentAt: DateTime.parse('2024-10-04T10:04:00.420'),
      ),
      numberOfUnreadMessages: 1,
      isClosed: false,
    ),
    Conversation(
      id: '2',
      practitioner: 'Verpleegkundigen',
      lastMessage: MessageSummary(
        text: verpleegkundigenWelcomeMessage,
        sentAt: DateTime.parse('2024-10-04T11:04:00.420'),
      ),
      numberOfUnreadMessages: 0,
      isClosed: true,
    ),
  ],
  '456': [
    Conversation(
      id: '3',
      practitioner: 'Zorgbijjou',
      lastMessage: MessageSummary(
        text:
            'Hi, welkom bij de app van Zorg bij jou. Je ontvangt zorg voor Diabetes, daarvoor ontvan',
        sentAt: DateTime.parse('2024-10-05T10:04:00.420'),
      ),
      numberOfUnreadMessages: 2,
      isClosed: false,
    ),
    Conversation(
      id: '4',
      practitioner: 'Verpleegkundigen',
      lastMessage: MessageSummary(
        text: verpleegkundigenWelcomeMessage,
        sentAt: DateTime.parse('2024-10-05T11:04:00.420'),
      ),
      numberOfUnreadMessages: 3,
      isClosed: true,
    ),
  ],
};

final mockConversationMessages = [
  ConversationMessages(
    id: '1',
    practitioner: 'Zorgbijjou',
    messages: [
      Message(
        text:
            'Welkom bij de app van Zorgbijjou. Je kan hier terecht voor al je vragen over de app en je zorgtraject. Hoe kan ik je helpen?',
        sentAt: DateTime.parse('2024-10-04T13:04:00.420'),
        user: const User(
          name: 'Dr Laura',
          type: 'practitioner',
        ),
      ),
      Message(
        text: 'Bedankt, ik ga rond kijken in de app',
        sentAt: DateTime.parse('2024-10-04T14:04:00.420'),
        user: const User(
          name: 'Patient',
          type: 'patient',
        ),
      ),
      Message(
        text: 'Hoe vind je de vormgeving van de app?',
        sentAt: DateTime.parse('2024-10-04T16:04:00.420'),
        user: const User(
          name: 'Dr Eliene',
          type: 'practitioner',
        ),
      ),
      Message(
        text:
            'Hallo, heb je vragen over de app of heb je suggesties om de app te verbeteren?',
        sentAt: DateTime.parse('2024-10-04T18:04:00.420'),
        user: const User(
          name: 'Dr Dennis',
          type: 'practitioner',
        ),
      ),
    ],
  ),
  ConversationMessages(
    id: '2',
    practitioner: 'Verpleegkundigen Maasstad',
    messages: [
      Message(
          text: verpleegkundigenWelcomeMessage,
          sentAt: DateTime.parse('2024-10-04T11:04:00.420'),
          isSystemMessage: true),
      Message(
        text:
            'Hi, ik zie aan je meting van 6 november 15:00 dat je klachten hebt. Hoe voelt u zich nu?',
        sentAt: DateTime.parse('2024-10-04T16:04:00.420'),
        user: const User(
          name: 'Dr Laurens',
          type: 'practitioner',
        ),
      ),
      Message(
        text: loremIpsum,
        sentAt: DateTime.parse('2024-10-04T17:04:00.420'),
        user: const User(
          name: 'Patient',
          type: 'patient',
        ),
      ),
      Message(
        text:
            'Dat klink niet best, blijf rustig en neem contact op als het erger wordt.',
        sentAt: DateTime.parse('2024-10-04T15:04:00.420'),
        user: const User(
          name: 'Dr Annelies',
          type: 'practitioner',
        ),
      ),
      Message(
        text: planVisitMessage,
        sentAt: DateTime.parse('2024-10-04T18:04:00.420'),
        user: const User(
          name: 'Dr Thijs',
          type: 'practitioner',
        ),
      ),
      Message(
        text: 'bedankt, ik zal rustig blijven',
        sentAt: DateTime.parse('2024-10-04T18:24:00.420'),
        user: const User(
          name: 'Patient',
          type: 'patient',
        ),
      ),
      Message(
        text: 'Hallo, hoe gaat het nu? Heb je nog klachten?',
        sentAt: DateTime.parse('2024-10-21T11:04:00.420'),
        user: const User(
          name: 'Dr Jente',
          type: 'practitioner',
        ),
      ),
    ],
  ),
];

var mockConsecutiveMessages = [
  Message(
      user: const User(name: 'name', type: 'practitioner'),
      text: 'Hello',
      sentAt: DateTime.now()),
  Message(
      user: const User(name: 'name', type: 'practitioner'),
      text: 'World',
      sentAt: DateTime.now()),
  Message(
      user: const User(name: 'name2', type: 'practitioner'),
      text: 'Hello',
      sentAt: DateTime.now()),
  Message(
      user: const User(name: 'name2', type: 'practitioner'),
      text: 'World',
      sentAt: DateTime.now()),
  Message(user: null, text: 'Hello', sentAt: DateTime.now()),
  Message(user: null, text: 'World', sentAt: DateTime.now()),
];

class MockChatDataSource extends Mock implements ChatDataSource {
  @override
  Future<ConversationMessages> fetchMessages(String conversationId) {
    return Future.value(mockConversationMessages
        .firstWhere((element) => element.id == conversationId));
  }
}
