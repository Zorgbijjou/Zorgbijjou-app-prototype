import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

enum ZbjGridSizedBoxAlignment {
  left,
  right,
}

class ZbjGridSizedBox extends StatelessWidget {
  final Widget? child;
  final int defaultColumnSpan;
  final Map<GridSize, int> columnSpans;
  final bool includeGutter;

  // This property is used by the GridPadding widget in order
  // to determine the padding to apply to the left or right side of the child widget.
  final ZbjGridSizedBoxAlignment alignment;

  const ZbjGridSizedBox({
    super.key,
    this.child,
    required this.defaultColumnSpan,
    required this.alignment,
    this.columnSpans = const <GridSize, int>{},
    this.includeGutter = false,
  });

  @override
  Widget build(BuildContext context) {
    var grid = context.currentGrid;
    var columnSpan = columnSpans[grid.name] ?? defaultColumnSpan;

    var width = context.calculateGridSizedBoxWidth(columnSpan, includeGutter);
    return SizedBox(width: width, child: child);
  }
}
