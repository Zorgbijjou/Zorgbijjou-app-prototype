import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/theme.dart';

import 'helpers.dart';

void main() {
  group('GridPadding', () {
    testWidgets(
        'should render left and right padding when no parent GridSizedBox',
        (tester) async {
      var width = 1200.0;
      tester.view.physicalSize = Size(width, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(materialAppWithTokens(
          child: const GridPadding(child: Text('Test widget'))));

      var context = tester.element(find.byType(GridPadding));
      var gridForWidth = context.getGridForWidth(width);

      var paddingWidget = tester.widget<Padding>(find.byType(Padding));

      expect(paddingWidget.padding,
          EdgeInsets.symmetric(horizontal: gridForWidth.columnMargin));
    });

    testWidgets(
        'should render only left padding when has parent GridSizedBox with left alignment',
        (tester) async {
      var width = 1200.0;
      tester.view.physicalSize = Size(width, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(materialAppWithTokens(
          child: const GridSizedBox(
        defaultColumnSpan: 1,
        alignment: GridSizedBoxAlignment.left,
        child: GridPadding(child: Text('Test widget')),
      )));

      var context = tester.element(find.byType(GridPadding));
      var gridForWidth = context.getGridForWidth(width);

      var paddingWidget = tester.widget<Padding>(find.byType(Padding));

      expect(
          paddingWidget.padding,
          EdgeInsets.only(
              left: gridForWidth.columnMargin, right: gridForWidth.columnGap));
    });

    testWidgets(
        'should render only right padding when has parent GridSizedBox with right alignment',
        (tester) async {
      var width = 1200.0;
      tester.view.physicalSize = Size(width, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(materialAppWithTokens(
          child: const GridSizedBox(
        defaultColumnSpan: 1,
        alignment: GridSizedBoxAlignment.right,
        child: GridPadding(child: Text('Test widget')),
      )));

      var context = tester.element(find.byType(GridPadding));
      var gridForWidth = context.getGridForWidth(width);

      var paddingWidget = tester.widget<Padding>(find.byType(Padding));

      expect(
          paddingWidget.padding,
          EdgeInsets.only(
              left: gridForWidth.columnGap, right: gridForWidth.columnMargin));
    });
  });
}

class MockCanvas extends Mock implements Canvas {}
