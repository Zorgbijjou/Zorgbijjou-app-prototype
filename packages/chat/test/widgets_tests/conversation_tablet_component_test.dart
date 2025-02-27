import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/assets/icons/custom_icons.dart';

import '../helpers.dart';

void main() {
  late ConversationsViewModel mockConversationsViewModel;
  late ConversationViewModel mockConversationViewModel;

  setUp(() {
    mockConversationsViewModel = const ConversationsViewModel();

    var conversations = mockConversations['123']!;
    mockConversationViewModel = ConversationViewModel(
      conversationId: conversations[0].id,
      conversation: conversations[0],
    );
  });

  Widget createWidgetUnderTest() {
    return materialAppWithTokens(
      child: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: ConversationsTabletComponent(
          conversationsViewModel: mockConversationsViewModel,
          activeConversationViewModel: mockConversationViewModel,
          onConversationClicked: (context, conversation) {},
          onMessageSendClicked: (context, message) {},
        ),
      ),
    );
  }

  testWidgets('displays loading indicator when loading',
      (WidgetTester tester) async {
    mockConversationViewModel = mockConversationViewModel.copyWith(
      isLoading: true,
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsExactly(2));
  });

  testWidgets('displays empty state when no conversations',
      (WidgetTester tester) async {
    mockConversationsViewModel = mockConversationsViewModel.copyWith(
      conversations: [],
      isLoading: false,
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Geen gesprekken'), findsOneWidget);
  });

  testWidgets('displays conversations list when conversations are available',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;

    var conversations = mockConversations['123']!;

    mockConversationsViewModel = mockConversationsViewModel.copyWith(
      conversations: conversations,
      isLoading: false,
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text(conversations[0].practitioner), findsExactly(2));
    expect(find.text(conversations[1].practitioner), findsOneWidget);
  });

  testWidgets('calls onConversationClicked when a conversation is tapped',
      (WidgetTester tester) async {
    late Conversation tappedConversation;

    var conversations = mockConversations['123']!;
    mockConversationsViewModel = mockConversationsViewModel.copyWith(
      conversations: conversations,
      isLoading: false,
    );

    await tester.pumpWidget(materialAppWithTokens(
      child: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: ConversationsTabletComponent(
          conversationsViewModel: mockConversationsViewModel,
          activeConversationViewModel: mockConversationViewModel,
          onConversationClicked: (context, conversation) {
            tappedConversation = conversation;
          },
          onMessageSendClicked: (context, message) {},
        ),
      ),
    ));

    await tester.pump();

    await tester.tap(find.text(conversations[1].practitioner));
    await tester.pump();

    expect(tappedConversation.id, '2');
  });

  // displays conversation when conversation is available
  testWidgets('displays conversation when conversation is available',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;

    var conversations = mockConversations['123']!;

    mockConversationsViewModel = mockConversationsViewModel.copyWith(
      conversations: conversations,
      isLoading: false,
    );

    mockConversationViewModel = mockConversationViewModel.copyWith(
      conversation: conversations[0],
      conversationMessages: mockConversationMessages[0],
      isLoading: false,
    );

    await tester.pumpWidget(materialAppWithTokens(
      child: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: ConversationsTabletComponent(
          conversationsViewModel: mockConversationsViewModel,
          activeConversationViewModel: mockConversationViewModel,
          onConversationClicked: (context, conversation) {},
          onMessageSendClicked: (context, message) {},
        ),
      ),
    ));

    await tester.pump();

    // display header
    expect(
      find.descendant(
        of: find.byType(ZbjSubLevelPageHeader),
        matching: find.text(conversations[0].practitioner),
      ),
      findsOneWidget,
    );

    expect(
      find.descendant(
        of: find.byType(ZbjSubLevelPageHeader),
        matching: find.byType(AvatarComponent),
      ),
      findsOneWidget,
    );

    // display a message
    expect(find.text(mockConversationMessages[0].messages![0].text),
        findsOneWidget);
  });

  testWidgets('calls onMessageSendClicked when a message is sent',
      (WidgetTester tester) async {
    late String sentMessage;

    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;

    var conversations = mockConversations['123']!;

    mockConversationsViewModel = mockConversationsViewModel.copyWith(
      conversations: conversations,
      isLoading: false,
    );

    mockConversationViewModel = mockConversationViewModel.copyWith(
      conversation: conversations[0],
      isLoading: false,
    );

    await tester.pumpWidget(materialAppWithTokens(
      child: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: ConversationsTabletComponent(
          conversationsViewModel: mockConversationsViewModel,
          activeConversationViewModel: mockConversationViewModel,
          onConversationClicked: (context, conversation) {},
          onMessageSendClicked: (context, message) {
            sentMessage = message;
          },
        ),
      ),
    ));

    await tester.pump();

    await tester.enterText(find.byType(TextField), 'hi, this is a message');

    var backButtonFinder = find.byIcon(CustomIcons.send_01);
    await tester.tap(backButtonFinder);

    expect(sentMessage, 'hi, this is a message');
  });
}
