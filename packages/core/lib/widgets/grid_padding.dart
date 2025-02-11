import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

import 'grid_sized_box.dart';

class GridPadding extends StatefulWidget {
  final Widget child;
  final double verticalPadding;

  const GridPadding({
    super.key,
    required this.child,
    this.verticalPadding = 0,
  });

  @override
  createState() => GridPaddingState();
}

class GridPaddingState extends State<GridPadding> {
  @override
  Widget build(BuildContext context) {
    var gridPadding = _getGridPadding(context);

    var childPadding = gridPadding.copyWith(
      top: widget.verticalPadding,
      bottom: widget.verticalPadding,
    );

    return Padding(padding: childPadding, child: widget.child);
  }

  EdgeInsets _getGridPadding(BuildContext context) {
    var parentState = context.findAncestorWidgetOfExactType<GridSizedBox>();

    var currentGrid = context.currentGrid;

    if (parentState == null) {
      return EdgeInsets.symmetric(horizontal: currentGrid.columnMargin);
    }

    if (parentState.alignment == GridSizedBoxAlignment.left) {
      return EdgeInsets.only(
          left: currentGrid.columnMargin, right: currentGrid.columnGap);
    }

    if (parentState.alignment == GridSizedBoxAlignment.right) {
      return EdgeInsets.only(
          left: currentGrid.columnGap, right: currentGrid.columnMargin);
    }

    throw Exception('Invalid GridSizedBoxAlignment');
  }
}
