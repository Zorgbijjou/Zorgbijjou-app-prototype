import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/theme.dart';

materialAppWithTokens({
  required Widget child,
  ITokens? tokens,
  required WidgetTester tester,
}) {
  return MediaQuery(
      data: MediaQueryData(size: tester.view.physicalSize),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Tokens(tokens: tokens ?? DefaultTokens(), child: child),
      ));
}

void main() {
  group('GridSizedBox', () {
    testWidgets('should render its child', (tester) async {
      var phoneView = const Size(430, 932);
      tester.view.physicalSize = phoneView;
      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(materialAppWithTokens(
          tester: tester,
          child: const GridSizedBox(
            defaultColumnSpan: 1,
            alignment: GridSizedBoxAlignment.left,
            child: Text('asdf'),
          )));

      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('should have correct width based on grid', (tester) async {
      var phoneView = const Size(430, 932);
      tester.view.physicalSize = phoneView;
      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(materialAppWithTokens(
          tester: tester,
          child: const GridSizedBox(
            defaultColumnSpan: 1,
            alignment: GridSizedBoxAlignment.left,
            child: Text('asdf'),
          )));

      var context = tester.element(find.byType(GridSizedBox));
      var expectedWidth = context.calculateGridSizedBoxWidth(1, false);

      var sizedBoxWidget = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(sizedBoxWidget.width, expectedWidth);
    });
  });
}
