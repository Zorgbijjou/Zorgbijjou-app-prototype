import 'package:chat/chat.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/user.dart';
import 'package:clock/clock.dart';
import 'package:core/l10n/core_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/theme.dart';

materialApp({required Widget child, ITokens? tokens}) {
  return MaterialApp(
    home: Localizations(
      delegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      locale: const Locale('nl'),
      child: Tokens(tokens: tokens ?? DefaultTokens(), child: child),
    ),
  );
}

void main() {
  group('MessageComponent', () {
    testWidgets('should render practitioner message', (tester) async {
      var fixedTime = DateTime(2024, 10, 10, 10, 10);
      await withClock(Clock.fixed(fixedTime), () async {
        await tester.pumpWidget(materialApp(
          child: MessageComponent(
            conversationTitle: '',
            message: Message(
              text: 'Message from the practitioner',
              user: const User(type: 'practitioner', name: 'Dr. Smith'),
              sentAt: fixedTime,
            ),
            isFirstMessage: true,
          ),
        ));
      });

      expect(find.byType(AvatarComponent), findsOneWidget);
      expect(find.text('Message from the practitioner'), findsOneWidget);
      expect(find.text('Dr. Smith'), findsOneWidget);
      expect(find.text('10:10'), findsOneWidget);
    });

    testWidgets('should not render practitioner avatar for second message',
        (tester) async {
      await tester.pumpWidget(materialApp(
        child: MessageComponent(
          conversationTitle: '',
          message: Message(
            text: 'Message from the practitioner',
            user: const User(type: 'practitioner', name: 'Dr. Smith'),
            sentAt: DateTime(2024, 10, 10, 10, 10),
          ),
          isFirstMessage: false,
        ),
      ));

      expect(find.byType(AvatarComponent), findsNothing);
    });

    testWidgets('should render patient message', (tester) async {
      var fixedTime = DateTime(2024, 10, 10, 10, 10);
      await withClock(Clock.fixed(fixedTime), () async {
        await tester.pumpWidget(materialApp(
          child: MessageComponent(
            conversationTitle: '',
            message: Message(
              text: 'Message from the patient',
              user: const User(type: 'patient', name: 'Mr. Smith'),
              sentAt: fixedTime,
            ),
            isFirstMessage: true,
          ),
        ));
      });

      expect(find.text('Message from the patient'), findsOneWidget);
      expect(find.text('Mr. Smith'), findsNothing);
      expect(find.text('10:10'), findsOneWidget);
    });

    testWidgets('should render system message', (tester) async {
      var fixedTime = DateTime(2024, 10, 10, 10, 10);
      await withClock(Clock.fixed(fixedTime), () async {
        await tester.pumpWidget(materialApp(
          child: MessageComponent(
            conversationTitle: '',
            message: Message(
              text: 'Message from the System',
              isSystemMessage: true,
              sentAt: DateTime(2024, 10, 10, 10, 10),
            ),
            isFirstMessage: true,
          ),
        ));
      });

      expect(find.text('Message from the System'), findsOneWidget);
      expect(find.text('The System'), findsNothing);
      expect(find.text('10:10'), findsOneWidget);
    });

    testWidgets('should render time from message today', (tester) async {
      var fixedTime = DateTime(2024, 10, 10, 10, 10);
      await withClock(Clock.fixed(fixedTime), () async {
        var fiveHoursAgo = fixedTime.subtract(const Duration(hours: 5));

        await tester.pumpWidget(materialApp(
          child: MessageComponent(
            conversationTitle: '',
            message: Message(
              text: 'Message from the System',
              isSystemMessage: true,
              sentAt: fiveHoursAgo,
            ),
            isFirstMessage: true,
          ),
        ));
      });

      expect(find.text('5:10'), findsOneWidget);
    });

    // should render for yesterday
    testWidgets('should render time from message yesterday', (tester) async {
      var fixedTime = DateTime(2024, 11, 10, 0, 0, 10);
      await withClock(Clock.fixed(fixedTime), () async {
        await tester.pumpWidget(materialApp(
          child: MessageComponent(
            conversationTitle: '',
            message: Message(
              text: 'Message from the System',
              isSystemMessage: true,
              sentAt: fixedTime.subtract(
                const Duration(seconds: 20),
              ),
            ),
            isFirstMessage: true,
          ),
        ));
      });

      expect(find.text('Gisteren, 23:59'), findsOneWidget);
    });

    testWidgets(
        'should render time from message yesterday when there is almost 2 days difference',
        (tester) async {
      var now = DateTime(2024, 11, 11, 23, 59, 10);
      var sentAt = DateTime(2024, 11, 10, 0, 0, 10);
      await withClock(Clock.fixed(now), () async {
        await tester.pumpWidget(materialApp(
          child: MessageComponent(
            conversationTitle: '',
            message: Message(
              text: 'Message from the System',
              isSystemMessage: true,
              sentAt: sentAt,
            ),
            isFirstMessage: true,
          ),
        ));
      });

      expect(find.text('Gisteren, 0:00'), findsOneWidget);
    });

    // should render for other days
    testWidgets('should render time from message other days', (tester) async {
      var fixedTime = DateTime(2024, 10, 10, 10, 10);
      await withClock(Clock.fixed(fixedTime), () async {
        var twoDaysAgo = fixedTime.subtract(const Duration(days: 2));

        await tester.pumpWidget(materialApp(
          child: MessageComponent(
            conversationTitle: '',
            message: Message(
              text: 'Message from the System',
              isSystemMessage: true,
              sentAt: twoDaysAgo,
            ),
            isFirstMessage: true,
          ),
        ));
      });

      expect(find.text('8 okt. 2024, 10:10'), findsOneWidget);
    });

    testWidgets('should render Markdown content', (tester) async {
      await tester.pumpWidget(materialApp(
        child: MessageComponent(
          conversationTitle: '',
          message: Message(
            text: '''# Test''',
            user: const User(type: 'practitioner', name: 'Dr. Smith'),
            sentAt: DateTime(2024, 10, 10, 10, 10),
          ),
          isFirstMessage: true,
        ),
      ));

      var formattedTextFinder = find.text('Test');
      var unformattedTextFinder = find.text('# Test');

      expect(formattedTextFinder, findsOneWidget);
      expect(unformattedTextFinder, isNot(findsAny));
    });

    testWidgets('should read message out loud', (tester) async {
      SemanticsHandle handle = tester.ensureSemantics();

      await tester.pumpWidget(materialApp(
        child: MessageComponent(
          conversationTitle: 'Zorgbijjou',
          message: Message(
            text: 'hello',
            user: const User(type: 'practitioner', name: 'Dr. Smith'),
            sentAt: DateTime(2024, 10, 10, 10, 10),
          ),
          isFirstMessage: true,
        ),
      ));

      expect(
          tester.getSemantics(find.text('hello')),
          matchesSemantics(
              label:
                  'Avatar Dr. Smith\nBericht van Dr. Smith. hello. Ontvangen in Zorgbijjou op 10oktober2024 10:10.'));

      handle.dispose();
    });
  });
}
