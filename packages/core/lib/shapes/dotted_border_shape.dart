import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class DottedBorderShape extends ShapeBorder {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  const DottedBorderShape({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    this.borderRadius = BorderRadius.zero,
  });

  factory DottedBorderShape.focusRing(
    BuildContext context, {
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return DottedBorderShape(
      color: context.tokens.color.tokensGrey800,
      strokeWidth: 2.0,
      dashWidth: 2.0,
      dashSpace: 2.0,
      borderRadius: borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(strokeWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect.deflate(strokeWidth / 2));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect);
  }

  Path _getPath(Rect rect) {
    if (borderRadius != BorderRadius.zero) {
      return Path()..addRRect(borderRadius.toRRect(rect));
    }
    return Path()..addRect(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint dashPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Paint gapPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = _getPath(rect);
    PathMetrics pathMetrics = path.computeMetrics();

    for (var pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        Path dashPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        Path gapPath = pathMetric.extractPath(
          distance + dashWidth,
          distance + dashWidth + dashSpace,
        );
        canvas.drawPath(dashPath, dashPaint);
        canvas.drawPath(gapPath, gapPaint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  ShapeBorder scale(double t) {
    return DottedBorderShape(
      color: color,
      strokeWidth: strokeWidth * t,
      dashWidth: dashWidth * t,
      dashSpace: dashSpace * t,
      borderRadius: borderRadius * t,
    );
  }
}
