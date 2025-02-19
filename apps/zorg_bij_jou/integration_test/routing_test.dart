import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:zorg_bij_jou/main.dart';
import 'package:zorg_bij_jou/routing/router.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Should show Home Page when routes to /',
      (WidgetTester tester) async {
    var router = createRouter();

    await tester
        .pumpWidget(MainApp(router: router, locale: const Locale('en')));

    router.go('/');
    await tester.pumpAndSettle();

    expect(find.textContaining('Heading 1'), findsOneWidget);
  });

  testWidgets('Should show Support Category when routes to /support-category',
      (WidgetTester tester) async {
    var router = createRouter();

    await tester
        .pumpWidget(MainApp(router: router, locale: const Locale('en')));

    router.go('/support-category/1');
    await tester.pumpAndSettle();

    expect(find.textContaining('Support category page'), findsOneWidget);
  });

  testWidgets('Should show 404 when Support Category routes without id',
      (WidgetTester tester) async {
    var router = createRouter();

    await tester
        .pumpWidget(MainApp(router: router, locale: const Locale('en')));

    router.go('/support-category');
    await tester.pumpAndSettle();

    expect(find.textContaining('404 - Page not found'), findsOneWidget);
  });

  testWidgets('Should show 404 when routes to unknown page',
      (WidgetTester tester) async {
    var router = createRouter();

    await tester
        .pumpWidget(MainApp(router: router, locale: const Locale('en')));

    router.go('/unknown-page');
    await tester.pumpAndSettle();

    expect(find.textContaining('404 - Page not found'), findsOneWidget);
  });
}
