import 'package:flutter/material.dart';

import 'dotted_border_shape.dart';

class DottedInputBorderShape extends InputBorder {
  final DottedBorderShape dottedShape;

  const DottedInputBorderShape({required this.dottedShape});

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return DottedInputBorderShape(
        dottedShape: borderSide != null
            ? DottedBorderShape(
                color: borderSide.color,
                strokeWidth: borderSide.width,
                dashWidth: dottedShape.dashWidth,
                dashSpace: dottedShape.dashSpace)
            : dottedShape);
  }

  @override
  EdgeInsetsGeometry get dimensions => dottedShape.dimensions;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return dottedShape.getInnerPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return dottedShape.getOuterPath(rect, textDirection: textDirection);
  }

  @override
  bool get isOutline => true;

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    dottedShape.paint(canvas, rect, textDirection: textDirection);
  }

  @override
  ShapeBorder scale(double t) => DottedInputBorderShape(
      dottedShape: dottedShape.scale(t) as DottedBorderShape);
}
