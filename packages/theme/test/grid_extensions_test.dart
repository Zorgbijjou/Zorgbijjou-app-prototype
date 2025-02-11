import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme/theme.dart';

void main() {
  group('GridExtensions', () {
    testWidgets('Provides phone grid tokens to the context', (tester) async {
      var phoneGrid = allGrids.elementAt(0);

      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(
              size: Size(phoneGrid.endBreakpoint.toDouble(), 300)),
          child: Tokens(tokens: DefaultTokens(), child: Container())));

      var element = tester.element(find.byType(Container));
      expect(element, isA<BuildContext>());
      var context = element as BuildContext;

      expect(context.currentGrid.name, equals(context.tokens.grids.xs.name));
    });

    testWidgets('Provides tablet grid tokens to the context', (tester) async {
      var tabletGrid = allGrids.elementAt(2);

      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(
              size: Size(tabletGrid.endBreakpoint.toDouble(), 300)),
          child: Tokens(tokens: DefaultTokens(), child: Container())));

      var element = tester.element(find.byType(Container));
      expect(element, isA<BuildContext>());
      var context = element as BuildContext;
      expect(context.currentGrid.name, equals(context.tokens.grids.md.name));
    });

    testWidgets('determines if the tablet view should be shown',
        (tester) async {
      var tabletGrid = allGrids.elementAt(2);

      var tabletWidthStartBreakpoint = tabletGrid.startBreakpoint.toDouble();
      var heightWhereAspectRatioIs1_5 = tabletWidthStartBreakpoint / 1.5;

      tester.view.physicalSize =
          Size(tabletWidthStartBreakpoint, heightWhereAspectRatioIs1_5);
      tester.view.devicePixelRatio = 1;

      var mediaQueryData = MediaQueryData(size: tester.view.physicalSize);
      await tester.pumpWidget(MediaQuery(
          data: mediaQueryData,
          child: Tokens(tokens: DefaultTokens(), child: const SizedBox())));

      var element = tester.element(find.byType(SizedBox));
      expect(element, isA<BuildContext>());
      var context = element as BuildContext;

      expect(context.isTabletView(), isTrue);
      expect(mediaQueryData.isTabletView(), isTrue);
    });

    testWidgets(
        'determines if the tablet view should not be shown on medium screens with a low aspect ratio',
        (tester) async {
      var tabletGrid = allGrids.elementAt(2);

      var tabletWidthStartBreakpoint = tabletGrid.startBreakpoint.toDouble();
      var heightWhereAspectRatioIs1_51 = tabletWidthStartBreakpoint / 1.51;

      tester.view.physicalSize =
          Size(tabletWidthStartBreakpoint, heightWhereAspectRatioIs1_51);
      tester.view.devicePixelRatio = 1;

      var mediaQueryData = MediaQueryData(size: tester.view.physicalSize);
      await tester.pumpWidget(MediaQuery(
          data: mediaQueryData,
          child: Tokens(tokens: DefaultTokens(), child: const SizedBox())));

      var element = tester.element(find.byType(SizedBox));
      expect(element, isA<BuildContext>());
      var context = element as BuildContext;

      expect(context.isTabletView(), isFalse);
      expect(mediaQueryData.isTabletView(), isFalse);
    });

    testWidgets(
        'determines if the tablet view should be shown on large screens',
        (tester) async {
      var tabletGrid = allGrids.elementAt(3);

      var tabletWidthStartBreakpoint = tabletGrid.startBreakpoint.toDouble();

      tester.view.physicalSize =
          Size(tabletWidthStartBreakpoint, tabletWidthStartBreakpoint / 2);
      tester.view.devicePixelRatio = 1;

      var mediaQueryData = MediaQueryData(size: tester.view.physicalSize);
      await tester.pumpWidget(MediaQuery(
          data: mediaQueryData,
          child: Tokens(tokens: DefaultTokens(), child: const SizedBox())));

      var element = tester.element(find.byType(SizedBox));
      expect(element, isA<BuildContext>());
      var context = element as BuildContext;

      expect(context.isTabletView(), isTrue);
      expect(mediaQueryData.isTabletView(), isTrue);
    });

    testWidgets('calculates sized box widths', (tester) async {
      var tabletGrid = allGrids.elementAt(3);

      var tabletWidthStartBreakpoint = tabletGrid.startBreakpoint.toDouble();

      tester.view.physicalSize =
          Size(tabletWidthStartBreakpoint, tabletWidthStartBreakpoint / 2);
      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(MediaQuery(
          data: MediaQueryData(size: tester.view.physicalSize),
          child: Tokens(tokens: DefaultTokens(), child: const SizedBox())));

      var element = tester.element(find.byType(SizedBox));
      expect(element, isA<BuildContext>());
      var context = element as BuildContext;

      var singleColumnWidth = context.calculateColumnWidth();
      var alwaysIncludeLeftOrRightMargin = tabletGrid.columnMargin;

      var expectedSizedBoxWithoutColumns = 0;
      expect(context.calculateGridSizedBoxWidth(0, false),
          equals(expectedSizedBoxWithoutColumns));

      var expectedSizedBoxWidthTwoColumnsWithoutGutter = singleColumnWidth * 2 +
          tabletGrid.columnGap +
          alwaysIncludeLeftOrRightMargin;

      expect(context.calculateGridSizedBoxWidth(2, false),
          equals(expectedSizedBoxWidthTwoColumnsWithoutGutter));

      var expectedSizedBoxWidthThreeColumnsWithoutGutter =
          singleColumnWidth * 3 +
              tabletGrid.columnGap * 2 +
              alwaysIncludeLeftOrRightMargin;

      expect(context.calculateGridSizedBoxWidth(3, false),
          equals(expectedSizedBoxWidthThreeColumnsWithoutGutter));

      var expectedSizedBoxWidthThreeColumnsIncludingGutter =
          expectedSizedBoxWidthThreeColumnsWithoutGutter + tabletGrid.columnGap;

      expect(context.calculateGridSizedBoxWidth(3, true),
          equals(expectedSizedBoxWidthThreeColumnsIncludingGutter));
    });
  });
}
