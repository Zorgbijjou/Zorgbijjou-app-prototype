import 'package:chat/chat.dart';
import 'package:chat/models/message_summary.dart';
import 'package:core/l10n/core_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

materialApp({required Widget child, ITokens? tokens}) {
  return MaterialApp(
    home: Tokens(
      tokens: tokens ?? DefaultTokens(),
      child: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: child,
      ),
    ),
  );
}

void main() {
  testWidgets(
      'ConversationsComponent should displays the 2 conversations correctly',
      (WidgetTester tester) async {
    List<Conversation> conversations = mockConversations['123']!;

    ConversationsViewModel viewModel = ConversationsViewModel(
      conversations: conversations,
      isLoading: false,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationsComponent(
        viewModel: viewModel,
        onConversationClicked: (context, conversationId) {},
      ),
    ));

    // Assert
    expect(find.text('Zorgbijjou'), findsOneWidget);
    expect(
        find.text(
            'In deze chat kan je alle vragen stellen die je hebt rondom het gebruik van deze app en nog meer dingen.'),
        findsOneWidget);
  });

  testWidgets(
      'ConversationsComponent should displays the 2 conversations in order of unread messages',
      (WidgetTester tester) async {
    List<Conversation> conversations = mockConversations['456']!;

    ConversationsViewModel viewModel = ConversationsViewModel(
      conversations: conversations,
      isLoading: false,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationsComponent(
        viewModel: viewModel,
        onConversationClicked: (context, conversationId) {},
      ),
    ));

    // Assert
    expect(find.text('Zorgbijjou'), findsOneWidget);
    expect(find.text('Verpleegkundigen'), findsOneWidget);

    Offset zorgbijjouPosition = tester.getTopLeft(find.text('Zorgbijjou'));
    Offset verpleegkundigenPosition =
        tester.getTopLeft(find.text('Verpleegkundigen'));

    expect(verpleegkundigenPosition.dy, lessThan(zorgbijjouPosition.dy));
  });

  testWidgets(
      'ConversationsComponent should displays a spinner when loading the conversations',
      (WidgetTester tester) async {
    List<Conversation> conversations = mockConversations['123']!;

    ConversationsViewModel viewModel = ConversationsViewModel(
      conversations: conversations,
      isLoading: true,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationsComponent(
        viewModel: viewModel,
        onConversationClicked: (context, conversationId) {},
      ),
    ));

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Zorgbijjou'), findsNothing);
    expect(
        find.text(
            'In deze chat kan je alle vragen stellen die je hebt rondom het gebruik van deze app en nog meer dingen.'),
        findsNothing);
  });

  testWidgets(
      'ConversationsComponent should goto conversation page after click',
      (WidgetTester tester) async {
    String clickedConversationId = '';
    ConversationsViewModel viewModel = ConversationsViewModel(
      conversations: [
        Conversation(
            id: 'conversation-id',
            practitioner: 'The Practitioner',
            numberOfUnreadMessages: 0,
            isClosed: false,
            lastMessage: MessageSummary(text: 'hoi', sentAt: DateTime.now()))
      ],
      isLoading: false,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationsComponent(
        viewModel: viewModel,
        onConversationClicked: (context, conversation) {
          clickedConversationId = conversation.id;
        },
      ),
    ));

    var conversationFinder = find.text('The Practitioner');
    await tester.tap(conversationFinder);

    // Assert
    expect(clickedConversationId, 'conversation-id');
  });
}
