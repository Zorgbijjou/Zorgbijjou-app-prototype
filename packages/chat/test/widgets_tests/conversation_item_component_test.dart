import 'package:chat/models/conversation.dart';
import 'package:chat/models/message_summary.dart';
import 'package:chat/widgets/conversation_item_component.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:core/shapes/dotted_border_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/theme.dart';

class MockCallback extends Mock {
  void call();
}

materialApp({required Widget child, ITokens? tokens}) {
  return MaterialApp(
      home: Localizations(
          delegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
          locale: const Locale('nl'),
          child: Tokens(tokens: tokens ?? DefaultTokens(), child: child)));
}

void main() {
  group('ConversationItemComponent', () {
    testWidgets('Should display a title, date and message', (tester) async {
      await tester.pumpWidget(materialApp(
          child: ConversationItemComponent(
        title: 'Test conversation item',
        description: 'Test message',
        hasUnreadMessages: false,
        time: DateTime(2024, 11, 15),
        semanticsLabel: (_) => '',
        onTap: () {},
      )));

      var formattedTextFinder = find.text('Test conversation item');
      var formattedDateFinder = find.text('15 nov. 2024');

      expect(formattedTextFinder, findsOneWidget);
      expect(formattedDateFinder, findsOneWidget);
    });

    testWidgets('Should display time for yesterday date', (tester) async {
      var fixedTime = DateTime(2024, 11, 14);
      await withClock(Clock.fixed(fixedTime), () async {
        await tester.pumpWidget(materialApp(
            child: ConversationItemComponent(
          title: 'Test conversation item',
          description: 'Test message',
          hasUnreadMessages: false,
          time: fixedTime.subtract(const Duration(days: 1)),
          semanticsLabel: (_) => '',
          onTap: () {},
        )));
      });

      var formattedDateFinder = find.text('Gisteren');

      expect(formattedDateFinder, findsOneWidget);
    });

    testWidgets('Should display time for today date', (tester) async {
      var fixedTime = DateTime(2024, 11, 15, 10, 10);
      await withClock(Clock.fixed(fixedTime), () async {
        await tester.pumpWidget(materialApp(
            child: ConversationItemComponent(
          title: 'Test conversation item',
          description: 'Test message',
          hasUnreadMessages: false,
          time: fixedTime,
          semanticsLabel: (_) => '',
          onTap: () {},
        )));
      });

      var formattedDateFinder = find.text('10:10');

      expect(formattedDateFinder, findsOneWidget);
    });

    testWidgets('Should display time for other dates', (tester) async {
      var fixedTime = DateTime(2024, 11, 10, 10, 10);
      await withClock(Clock.fixed(fixedTime), () async {
        await tester.pumpWidget(materialApp(
            child: ConversationItemComponent(
          title: 'Test conversation item',
          description: 'Test message',
          hasUnreadMessages: false,
          time: fixedTime.subtract(const Duration(days: 2)),
          semanticsLabel: (_) => '',
          onTap: () {},
        )));
      });

      var formattedDateFinder = find.text('8 nov. 2024');

      expect(formattedDateFinder, findsOneWidget);
    });

    // Test stripping of HTML tags
    testWidgets('Should strip HTML tags from the description', (tester) async {
      await tester.pumpWidget(materialApp(
          child: ConversationItemComponent(
        title: 'Test conversation item',
        description: 'Test <b>message</b>',
        hasUnreadMessages: false,
        time: DateTime(2024, 11, 15),
        semanticsLabel: (_) => '',
        onTap: () {},
      )));

      var formattedTextFinder = find.text('Test message');
      expect(formattedTextFinder, findsOneWidget);
    });

    // should replace paragraph with a space
    testWidgets('Should replace paragraph with a space and trim description',
        (tester) async {
      await tester.pumpWidget(materialApp(
          child: ConversationItemComponent(
        title: 'Test conversation item',
        description: '<p>Test</p><p>message</p>',
        hasUnreadMessages: false,
        time: DateTime(2024, 11, 15),
        semanticsLabel: (_) => '',
        onTap: () {},
      )));

      var formattedTextFinder = find.text('Test message');
      expect(formattedTextFinder, findsOneWidget);
    });

    testWidgets('Should focus the ConversationItemComponent when focused',
        (tester) async {
      var tokens = DefaultTokens();
      await tester.pumpWidget(materialApp(
        tokens: tokens,
        child: ConversationItemComponent(
          title: 'Test conversation item',
          description: 'Test message',
          hasUnreadMessages: false,
          time: DateTime(2024, 11, 15),
          semanticsLabel: (_) => '',
          onTap: () {},
        ),
      ));

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      var focusWidget = find.byKey(const Key('outlined_focus'));
      expect(focusWidget, findsOneWidget);

      expect(
          tester.widget<Material>(focusWidget).shape, isA<DottedBorderShape>());
    });

    testWidgets('Should handle keyboard interaction and call onTap',
        (tester) async {
      // Create a FocusNode that will be passed to the ConversationItemComponent
      var mockCallback = MockCallback();

      await tester.pumpWidget(materialApp(
        child: ConversationItemComponent(
          title: 'Test conversation item',
          description: 'Test message',
          hasUnreadMessages: false,
          time: DateTime(2024, 11, 15),
          semanticsLabel: (_) => '',
          onTap: mockCallback.call,
        ),
      ));

      // Simulate a user pressing the Tab key to focus the ConversationItemComponent
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      var focusWidget = find.byKey(const Key('outlined_focus'));

      expect(focusWidget, findsOneWidget);

      expect(
          tester.widget<Material>(focusWidget).shape, isA<DottedBorderShape>());

      // Simulate a user pressing the Enter key to activate the ConversationItemComponent
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      // Verify the onTap callback is called
      verify(() => mockCallback()).called(1);
    });

    testWidgets(
      'Screen reader announces correct name when OutlinedFocus is focused',
      (WidgetTester tester) async {
        await tester.pumpWidget(materialApp(
          child: ConversationItemComponent(
            title: 'Test conversation item',
            description: 'Test sender, nurse: Test message.',
            hasUnreadMessages: false,
            semanticsLabel: (_) =>
                'Test conversation item. Bericht van Test sender, nurse, Test message. 15 november 2024.',
            time: DateTime(2024, 11, 15),
            onTap: () {},
          ),
        ));

        expect(
          tester.getSemantics(find.byType(InkWell)),
          containsSemantics(
              label:
                  'Test conversation item. Bericht van Test sender, nurse, Test message. 15 november 2024.'),
        );
      },
    );

    testWidgets(
      'Screen reader announces conversation with 1 unread message',
      (WidgetTester tester) async {
        await tester.pumpWidget(materialApp(
          child: ConversationItemComponent.fromConversation(
            conversation: Conversation(
              id: '1',
              practitioner: 'Test Practitioner',
              lastMessage: MessageSummary(
                text: 'Test message',
                sentAt: DateTime(2024, 11, 15),
              ),
              numberOfUnreadMessages: 1,
              isClosed: false,
            ),
            onTap: () {},
          ),
        ));

        expect(
          tester.getSemantics(find.byType(InkWell)),
          containsSemantics(
              label:
                  'Bericht: Test Practitioner. Test message. 15november2024 00:00. 1 ongelezen bericht.'),
        );
      },
    );

    testWidgets(
      'Screen reader announces conversation with n unread message',
      (WidgetTester tester) async {
        await tester.pumpWidget(materialApp(
          child: ConversationItemComponent.fromConversation(
            conversation: Conversation(
              id: '1',
              practitioner: 'Test Practitioner',
              lastMessage: MessageSummary(
                text: 'Test message',
                sentAt: DateTime(2024, 11, 15),
              ),
              numberOfUnreadMessages: 4,
              isClosed: false,
            ),
            onTap: () {},
          ),
        ));

        expect(
          tester.getSemantics(find.byType(InkWell)),
          containsSemantics(
              label:
                  'Bericht: Test Practitioner. Test message. 15november2024 00:00. 4 ongelezen berichten.'),
        );
      },
    );

    testWidgets(
      'Screen reader announces conversation without a message',
      (WidgetTester tester) async {
        await tester.pumpWidget(materialApp(
          child: ConversationItemComponent.fromConversation(
            conversation: const Conversation(
              id: '1',
              practitioner: 'Test Practitioner',
              lastMessage: null,
              numberOfUnreadMessages: 0,
              isClosed: false,
            ),
            onTap: () {},
          ),
        ));

        expect(
          tester.getSemantics(find.byType(InkWell)),
          containsSemantics(label: 'Bericht: Test Practitioner.'),
        );
      },
    );

    testWidgets('Should display message style', (tester) async {
      await tester.pumpWidget(materialApp(
          child: ConversationItemComponent(
        title: 'Test conversation item',
        description: 'Test message',
        hasUnreadMessages: false,
        time: DateTime(2024, 11, 15),
        semanticsLabel: (_) => '',
        onTap: () {},
      )));

      var formattedTextFinder = find.text('Test conversation item');
      Text textWidget = tester.widget<Text>(formattedTextFinder);

      expect(
          textWidget.style,
          DefaultTokens().textStyle.tokensTypographyParagraphBoldMd.copyWith(
                color: DefaultTokens().color.tokensGrey800,
              ));
    });

    testWidgets('Should display unread message style', (tester) async {
      await tester.pumpWidget(materialApp(
          child: ConversationItemComponent(
        title: 'Test conversation item',
        description: 'Test message',
        hasUnreadMessages: true,
        time: DateTime(2024, 11, 15),
        semanticsLabel: (_) => '',
        onTap: () {},
      )));

      var formattedTextFinder = find.text('Test conversation item');
      Text textWidget = tester.widget<Text>(formattedTextFinder);

      expect(
          textWidget.style,
          DefaultTokens().textStyle.tokensTypographyParagraphBoldMd.copyWith(
                color: DefaultTokens().color.tokensTurqoise600,
              ));
    });
  });
}
