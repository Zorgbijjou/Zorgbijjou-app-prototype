import 'package:core/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/theme.dart';

import 'helpers.dart';

void main() {
  group('PageHeader sub level', () {
    testWidgets('Should display a title, subtitle, introduction and icon',
        (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: PageHeader.subLevel(
          title: 'Test page header',
          subtitle: 'Some subtitle',
          introduction: 'Test intro',
          icon: const Icon(CustomIcons.help_circle),
          avatar: const CircleAvatar(),
        ),
      ));

      var titleFinder = find.text('Test page header');
      var subtitleFinder = find.text('Some subtitle');
      var introductionFinder = find.text('Test intro');
      var iconFinder = find.byIcon(CustomIcons.help_circle);
      var avatarFinder = find.byType(CircleAvatar);

      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);
      expect(introductionFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
      expect(avatarFinder, findsOneWidget);
    });

    testWidgets('Should not display avatar and icon', (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: PageHeader.subLevel(
          title: 'Test page header',
        ),
      ));

      var titleFinder = find.text('Test page header');
      var emptyIconFinder = find.byKey(const Key('empty_icon'));
      var emptyAvatarFinder = find.byKey(const Key('empty_avatar'));

      expect(titleFinder, findsOneWidget);
      expect(emptyIconFinder, findsOneWidget);
      expect(emptyAvatarFinder, findsOneWidget);
    });
  });

  group('PageHeader first level', () {
    testWidgets('Should display a title and icon', (tester) async {
      await tester.pumpWidget(materialAppWithTokens(
        child: PageHeader.firstLevel(
          title: 'Test page header',
          icon: const Icon(CustomIcons.help_circle),
        ),
      ));

      var titleFinder = find.text('Test page header');
      var iconFinder = find.byIcon(CustomIcons.help_circle);

      expect(titleFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });
  });
}
