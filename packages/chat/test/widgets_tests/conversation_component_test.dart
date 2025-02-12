import 'package:chat/chat.dart';
import 'package:chat/models/conversation_messages.dart';
import 'package:chat/models/message.dart';
import 'package:core/l10n/core_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/assets/icons/custom_icons.dart';
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
  testWidgets('ConversationComponent should displays a conversation correctly',
      (WidgetTester tester) async {
    ConversationViewModel viewModel = ConversationViewModel(
      conversationId: '2',
      conversation: mockConversation,
      conversationMessages: mockConversationMessages[0],
      isLoading: false,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationComponent(
        pageHeader: const SizedBox(),
        viewModel: viewModel,
        onMessageSendClicked: (BuildContext context, String message) {},
      ),
    ));

    await tester.pumpAndSettle();

    // Assert
    expect(
        find.text(
            'Welkom bij de app van Zorgbijjou. Je kan hier terecht voor al je vragen over de app en je zorgtraject. Hoe kan ik je helpen?'),
        findsOneWidget);

    expect(find.byType(MessageComponent), findsExactly(4));
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets(
      'ConversationComponent should displays a spinner when loading the conversation',
      (WidgetTester tester) async {
    ConversationViewModel viewModel = const ConversationViewModel(
      conversationId: '1',
      conversation: Conversation(
        id: '1',
        practitioner: 'The practitioner',
        numberOfUnreadMessages: 1,
        isClosed: false,
      ),
      isLoading: true,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationComponent(
        pageHeader: const SizedBox(),
        viewModel: viewModel,
        onMessageSendClicked: (BuildContext context, String message) {},
      ),
    ));

    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
        find.text(
            'Hi, ik zie aan je meting van 6 november 15:00 dat je klachten hebt. Hoe voelt u zich nu?'),
        findsNothing);
  });

  testWidgets('ConversationComponent should send message on sendButton clicked',
      (WidgetTester tester) async {
    String messageToSend = '';
    ConversationViewModel viewModel = ConversationViewModel(
      conversationId: '1',
      conversation: mockConversation,
      conversationMessages: mockConversationMessages[0],
      isLoading: false,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationComponent(
        pageHeader: const SizedBox(),
        viewModel: viewModel,
        onMessageSendClicked: (BuildContext context, String message) {
          messageToSend = message;
        },
      ),
    ));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'hi, this is a message');

    var backButtonFinder = find.byIcon(CustomIcons.send_01);
    await tester.tap(backButtonFinder);

    // Assert
    expect(messageToSend, 'hi, this is a message');
  });

  // should render isFirstMessage based on consecutive correctly
  testWidgets(
      'ConversationComponent should render isFirstMessage based on consecutive correctly',
      (WidgetTester tester) async {
    List<Message> messages = mockConsecutiveMessages;

    ConversationMessages conversationMessages = ConversationMessages(
      messages: messages,
      id: '123',
      practitioner: 'Dr. John Doe',
    );

    ConversationViewModel viewModel = ConversationViewModel(
      conversationId: '123',
      conversation: null,
      conversationMessages: conversationMessages,
      isLoading: false,
    );

    // Act
    await tester.pumpWidget(
      materialApp(
        child: ConversationComponent(
          pageHeader: const SizedBox(),
          viewModel: viewModel,
          onMessageSendClicked: (BuildContext context, String message) {},
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(AvatarComponent), findsExactly(2));

    expect(
      find.descendant(
        of: find.byType(MessageComponent).at(0),
        matching: find.byType(AvatarComponent),
      ),
      findsOneWidget,
    );

    expect(
      find.descendant(
        of: find.byType(MessageComponent).at(2),
        matching: find.byType(AvatarComponent),
      ),
      findsOneWidget,
    );
  });

  testWidgets('ConversationComponent should scroll to the last message',
      (WidgetTester tester) async {
    ConversationViewModel viewModel = ConversationViewModel(
      conversationId: '1',
      conversation: mockConversation,
      // empty messages
      conversationMessages:
          const ConversationMessages(id: '', practitioner: ''),
      isLoading: false,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationComponent(
        pageHeader: const SizedBox(),
        viewModel: viewModel,
        onMessageSendClicked: (BuildContext context, String message) {},
      ),
    ));

    await tester.pumpAndSettle();

    ConversationMessages conversationMessages = mockConversationMessages[0];
    var viewModelWithMessages = viewModel.copyWith(
      conversationMessages: conversationMessages,
    );

    // simulate didUpdateWidget
    await tester.pumpWidget(materialApp(
      child: ConversationComponent(
        pageHeader: const SizedBox(),
        viewModel: viewModelWithMessages,
        onMessageSendClicked: (BuildContext context, String message) {},
      ),
    ));

    // Assert
    int messageFocusIndex = viewModelWithMessages.focusMessageIndex;
    expect(messageFocusIndex, greaterThan(0));
    expect(find.byType(MessageComponent).at(messageFocusIndex), findsOneWidget);

    RenderBox scrollBox =
        tester.renderObject(find.byType(SingleChildScrollView));

    // Verify that the first message isn't visible
    var firstMessageFinder =
        find.text(conversationMessages.messages!.first.text).last;
    RenderBox firstMessageBox = tester.renderObject(firstMessageFinder);
    expect(
        scrollBox.paintBounds
            .contains(firstMessageBox.localToGlobal(Offset.zero)),
        isFalse);

    // Verify that the last message is visible
    var lastMessageFinder =
        find.text(conversationMessages.messages!.last.text).last;
    RenderBox lastMessageBox = tester.renderObject(lastMessageFinder);
    expect(
        scrollBox.paintBounds
            .contains(lastMessageBox.localToGlobal(Offset.zero)),
        isTrue);
  });

  testWidgets('ConversationComponent should scroll to the unread message',
      (WidgetTester tester) async {
    ConversationMessages conversationMessages = mockConversationMessages[0];
    ConversationViewModel viewModel = ConversationViewModel(
      conversationId: '1',
      conversation: mockConversation,
      conversationMessages: conversationMessages,
      unreadMessagesCount: conversationMessages.messages!.length - 1,
      isLoading: false,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationComponent(
        pageHeader: const SizedBox(),
        viewModel: viewModel,
        onMessageSendClicked: (BuildContext context, String message) {},
      ),
    ));

    await tester.pumpAndSettle();

    // Assert
    RenderBox scrollBox =
        tester.renderObject(find.byType(SingleChildScrollView));

    // Verify that the first message isn't visible
    var firstMessageFinder =
        find.text(conversationMessages.messages!.first.text);
    RenderBox firstMessageBox = tester.renderObject(firstMessageFinder);
    expect(
        scrollBox.paintBounds
            .contains(firstMessageBox.localToGlobal(Offset.zero)),
        isTrue);

    // Verify that the last message isn't visible
    var lastMessageFinder =
        find.text(conversationMessages.messages!.last.text).last;
    RenderBox lastMessageBox = tester.renderObject(lastMessageFinder);
    expect(
        scrollBox.paintBounds
            .contains(lastMessageBox.localToGlobal(Offset.zero)),
        isFalse);
  });

  testWidgets('ConversationComponent should show new message divider',
      (WidgetTester tester) async {
    ConversationMessages conversationMessages = mockConversationMessages[0];
    ConversationViewModel viewModel = ConversationViewModel(
      conversationId: '1',
      conversation: mockConversation,
      conversationMessages: conversationMessages,
      unreadMessagesCount: 1,
      isLoading: false,
      error: null,
    );

    // Act
    await tester.pumpWidget(materialApp(
      child: ConversationComponent(
        pageHeader: const SizedBox(),
        viewModel: viewModel,
        onMessageSendClicked: (BuildContext context, String message) {},
      ),
    ));

    await tester.pumpAndSettle();

    // Assert
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Divider &&
            widget.color == DefaultTokens().color.tokensTurqoise700),
        findsExactly(2));
  });

  // keyboard should close when tapping messages list
  testWidgets('Keyboard should close when tapping messages list',
      (WidgetTester tester) async {
    // Arrange
    var viewModel = ConversationViewModel(
      conversationId: '1',
      conversation: mockConversation,
      conversationMessages: mockConversationMessages[0],
      isLoading: false,
      error: null,
    );

    await tester.pumpWidget(
      materialApp(
        child: ConversationComponent(
          pageHeader: const SizedBox(),
          viewModel: viewModel,
          onMessageSendClicked: (BuildContext context, String message) {},
        ),
      ),
    );

    await tester.pumpAndSettle();

    // --- Step 1: Tap on the TextField to open the keyboard/focus ---
    var textFieldFinder = find.byType(TextField);
    await tester.tap(textFieldFinder);
    await tester.pumpAndSettle();

    // Confirm that the TextField is now focused
    expect(
      FocusScope.of(tester.element(textFieldFinder)).hasFocus,
      isTrue,
      reason: 'TextField should be focused after tapping on it',
    );

    // --- Step 2: Tap on the messages list to close the keyboard ---
    var messagesListFinder = find.byType(SingleChildScrollView);
    await tester.tap(messagesListFinder);
    await tester.pumpAndSettle();

    // --- Step 3: Verify the TextField is no longer focused ---
    expect(
      FocusScope.of(tester.element(textFieldFinder)).hasFocus,
      isFalse,
      reason: 'TextField should lose focus when tapping on the messages list',
    );
  });

  testWidgets('Keyboard should close when scrolling up quickly',
      (WidgetTester tester) async {
    // Arrange
    var viewModel = ConversationViewModel(
      conversationId: '1',
      conversation: mockConversation,
      conversationMessages: mockConversationMessages[0],
      unreadMessagesCount: 0,
      isLoading: false,
      error: null,
    );

    tester.view.physicalSize = const Size(800, 1200);

    await tester.pumpWidget(
      materialApp(
        child: MediaQuery(
          data: MediaQueryData(size: tester.view.physicalSize),
          child: ConversationComponent(
            pageHeader: const SizedBox(),
            viewModel: viewModel,
            onMessageSendClicked: (BuildContext context, String message) {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // --- Step 1: Scroll down to the bottom
    var scrollViewFinder = find.byType(SingleChildScrollView);

    SingleChildScrollView scrollView = tester.widget(scrollViewFinder);
    ScrollController scrollController = scrollView.controller!;
    scrollController.jumpTo(scrollController.position.maxScrollExtent);

    // --- Step 2: Tap on the TextField to open the keyboard/focus ---
    var textFieldFinder = find.byType(TextField);
    await tester.tap(textFieldFinder);
    await tester.pumpAndSettle();

    // Confirm that the TextField is now focused
    expect(
      FocusScope.of(tester.element(textFieldFinder)).hasFocus,
      isTrue,
      reason: 'TextField should be focused after tapping on it',
    );

    //  --- Step 3: Scroll up quickly to close the keyboard ---
    await tester.fling(
      find.byType(SingleChildScrollView),
      const Offset(0, 1000), // fling up by 300px
      1500, // velocity in logical pixels per second
    );

    // Allow any animations or focus changes to settle
    await tester.pumpAndSettle();

    // --- Step 4: Verify the TextField is no longer focused ---
    expect(
      FocusScope.of(tester.element(textFieldFinder)).hasFocus,
      isFalse,
      reason: 'TextField should lose focus when scrolling quickly',
    );
  });

  testWidgets('Keyboard should remain open when scrolling up slowly',
      (WidgetTester tester) async {
    // Arrange
    var viewModel = ConversationViewModel(
      conversationId: '1',
      conversation: mockConversation,
      conversationMessages: mockConversationMessages[0],
      unreadMessagesCount: 0,
      isLoading: false,
      error: null,
    );

    await tester.pumpWidget(materialApp(
      child: ConversationComponent(
        pageHeader: const SizedBox(),
        viewModel: viewModel,
        onMessageSendClicked: (BuildContext context, String message) {},
      ),
    ));

    await tester.pumpAndSettle();

    // --- Step 1: Scroll down to the bottom
    var scrollViewFinder = find.byType(SingleChildScrollView);

    SingleChildScrollView scrollView = tester.widget(scrollViewFinder);
    ScrollController scrollController = scrollView.controller!;
    scrollController.jumpTo(scrollController.position.maxScrollExtent);

    // --- Step 1: Tap on the TextField to open the keyboard/focus ---
    var textFieldFinder = find.byType(TextField);
    await tester.tap(textFieldFinder);
    await tester.pumpAndSettle();

    // Confirm that the TextField is now focused
    expect(
      FocusScope.of(tester.element(textFieldFinder)).hasFocus,
      isTrue,
      reason: 'TextField should be focused after tapping on it',
    );

    // Act
    await tester.fling(
      find.byType(SingleChildScrollView),
      const Offset(0, 1000), // fling up by 300px
      1000, // velocity in logical pixels per second
    );

    await tester.pumpAndSettle();

    // Assert
    expect(
        FocusScope.of(tester.element(find.byType(ConversationComponent)))
            .hasFocus,
        isTrue);
  });
}
