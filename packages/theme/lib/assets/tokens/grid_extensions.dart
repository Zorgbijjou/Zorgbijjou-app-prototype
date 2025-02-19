import 'package:flutter/material.dart';

import 'grid_tokens.dart';
import 'tokens.g.dart';

extension GridTokenExtension on ITokens {
  GridTokens get grids => DefaultGridTokens();
}

extension MediaQueryExtensions on MediaQueryData {
  isTabletView() {
    var data = this;
    var gridTokens = DefaultGridTokens();

    return isTablet(gridTokens, data.size);
  }
}

extension Grids on BuildContext {
  GridTokenValues get currentGrid {
    var width = MediaQuery.sizeOf(this).width.ceil();

    return getGridForWidth(width);
  }

  GridTokenValues getGridForWidth(num width) {
    return allGrids.singleWhere(
      (grid) => grid.startBreakpoint <= width && grid.endBreakpoint >= width,
    );
  }

  bool isTabletView() {
    var size = MediaQuery.sizeOf(this);

    return isTablet(tokens.grids, size);
  }

  double calculateColumnWidth() {
    var grid = currentGrid;

    var gapCount = grid.columnCount - 1;

    var screenWidth = MediaQuery.sizeOf(this).width;
    var bodyWidth = screenWidth - grid.columnMargin * 2;
    var columnWidth =
        (bodyWidth - (grid.columnGap * gapCount)) / grid.columnCount;

    return columnWidth;
  }

  double calculateGridSizedBoxWidth(int spannedColumns, bool includeGutter) {
    var grid = currentGrid;
    if (spannedColumns == 0 || spannedColumns > grid.columnCount) {
      return 0;
    }

    var columnWidth = calculateColumnWidth();

    var spannedGaps = spannedColumns - (includeGutter ? 0 : 1);

    return (spannedColumns * columnWidth) +
        (spannedGaps * grid.columnGap) +
        grid.columnMargin;
  }
}

bool isTablet(GridTokens gridTokens, Size size) {
  return size.width >= gridTokens.lg.startBreakpoint ||
      (size.width >= gridTokens.md.startBreakpoint && size.aspectRatio <= 1.5);
}
