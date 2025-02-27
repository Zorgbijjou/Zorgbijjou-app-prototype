import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

import 'grid_sized_box.dart';

class ZbjGridPadding extends StatefulWidget {
  final Widget child;
  final double verticalPadding;

  const ZbjGridPadding({
    super.key,
    required this.child,
    this.verticalPadding = 0,
  });

  @override
  createState() => ZbjGridPaddingState();
}

class ZbjGridPaddingState extends State<ZbjGridPadding> {
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
    var parentState = context.findAncestorWidgetOfExactType<ZbjGridSizedBox>();

    var currentGrid = context.currentGrid;

    if (parentState == null) {
      return EdgeInsets.symmetric(horizontal: currentGrid.columnMargin);
    }

    if (parentState.alignment == ZbjGridSizedBoxAlignment.left) {
      return EdgeInsets.only(
          left: currentGrid.columnMargin, right: currentGrid.columnGap);
    }

    if (parentState.alignment == ZbjGridSizedBoxAlignment.right) {
      return EdgeInsets.only(
          left: currentGrid.columnGap, right: currentGrid.columnMargin);
    }

    throw Exception('Invalid GridSizedBoxAlignment');
  }
}
