import 'package:chat/chat.dart';
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
        child: Tokens(tokens: tokens ?? DefaultTokens(), child: child)),
  );
}

void main() {
  group('AvatarComponent', () {
    testWidgets('should render initials', (tester) async {
      await tester.pumpWidget(
          materialApp(child: AvatarComponent.small(name: 'Test Patient')));

      expect(find.text('TP'), findsOneWidget);
    });

    testWidgets('should render single initial', (tester) async {
      await tester
          .pumpWidget(materialApp(child: AvatarComponent.small(name: 'Test')));

      expect(find.text('T'), findsOneWidget);
    });

    testWidgets('should render only the first and last initials',
        (tester) async {
      await tester.pumpWidget(
          materialApp(child: AvatarComponent.small(name: 'Test of Patient')));

      expect(find.text('TP'), findsOneWidget);
    });

    testWidgets('should not fail if no name is given', (tester) async {
      await tester
          .pumpWidget(materialApp(child: AvatarComponent.small(name: '')));

      expect(find.text(''), findsOneWidget);
    });
  });

  testWidgets('should read avatar out loud', (tester) async {
    SemanticsHandle handle = tester.ensureSemantics();
    await tester
        .pumpWidget(materialApp(child: AvatarComponent.small(name: 'Test')));

    expect(find.text('T'), findsOneWidget);

    expect(tester.getSemantics(find.text('T')),
        matchesSemantics(label: 'Avatar Test'));

    handle.dispose();
  });
}
