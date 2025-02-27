import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/grid_extensions.dart';
import 'package:theme/assets/tokens/grid_tokens.dart';

class ZbjGridOverlay extends StatelessWidget {
  const ZbjGridOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var width = constraints.maxWidth;
      var gridValues = context.getGridForWidth(width);

      return CustomPaint(
        key: Key('paint_grid_${gridValues.name.name}'),
        size: Size.infinite,
        painter: _GridPainter(gridValues),
      );
    });
  }
}

class _GridPainter extends CustomPainter {
  final GridTokenValues gridValues;

  _GridPainter(this.gridValues);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    double totalWidth = size.width;
    double columnWidth = (totalWidth -
            (gridValues.columnMargin * 2) -
            (gridValues.columnGap * (gridValues.columnCount - 1))) /
        gridValues.columnCount;

    for (int i = 0; i < gridValues.columnCount; i++) {
      double left =
          gridValues.columnMargin + i * (columnWidth + gridValues.columnGap);
      double right = left + columnWidth;
      canvas.drawRect(Rect.fromLTRB(left, 0, right, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
