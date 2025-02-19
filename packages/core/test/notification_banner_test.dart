import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/assets/icons/custom_icons.dart';

import 'helpers.dart';

void main() {
  testWidgets('Should contain title, content and icon', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
      child: NotificationBanner.negative(
        title: 'A Title',
        content: 'The content',
      ),
    ));

    expect(find.text('A Title'), findsOneWidget);
    expect(find.text('The content'), findsOneWidget);
    expect(find.byIcon(CustomIcons.alert_octagon), findsOneWidget);
    expect(find.byIcon(CustomIcons.x), findsNothing);
  });

  testWidgets('Should contain title, content and icon', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
      child: NotificationBanner.positive(
        title: 'A Title',
        content: 'The content',
      ),
    ));

    expect(find.text('A Title'), findsOneWidget);
    expect(find.text('The content'), findsOneWidget);
    expect(find.byIcon(CustomIcons.check_circle), findsOneWidget);
    expect(find.byIcon(CustomIcons.x), findsNothing);
  });

  testWidgets('Should contain close button', (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
      child: NotificationBanner.negative(
        title: 'A Title',
        content: 'The content',
        closable: true,
      ),
    ));

    expect(find.byIcon(CustomIcons.x), findsOneWidget);
  });

  testWidgets('Should close banner when close button is clicked',
      (tester) async {
    await tester.pumpWidget(materialAppWithTokens(
      child: NotificationBanner.negative(
        title: 'A Title',
        content: 'The content',
        closable: true,
      ),
    ));

    expect(find.byIcon(CustomIcons.x), findsOneWidget);
    expect(find.text('A Title'), findsOneWidget);
    expect(find.text('The content'), findsOneWidget);

    await tester.tap(find.byIcon(CustomIcons.x));
    await tester.pumpAndSettle();

    expect(find.byIcon(CustomIcons.x), findsNothing);
    expect(find.text('A Title'), findsNothing);
    expect(find.text('The content'), findsNothing);
  });
}
