import 'package:core/shapes/dotted_border_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DottedBorderShape', () {
    test('Dimensions should be based on strokeWidth', () {
      const dottedBorder = DottedBorderShape(
        color: Colors.black,
        strokeWidth: 4.0,
        dashWidth: 3.0,
        dashSpace: 3.0,
      );

      // The dimension should be the stroke width as padding
      expect(dottedBorder.dimensions, const EdgeInsets.all(4.0));
    });

    test('getOuterPath should return correct path for rect', () {
      const dottedBorder = DottedBorderShape(
        color: Colors.black,
        strokeWidth: 2.0,
        dashWidth: 2.0,
        dashSpace: 2.0,
      );

      Rect rect = const Rect.fromLTWH(0, 0, 100, 50);
      Path outerPath = dottedBorder.getOuterPath(rect);

      // The outer path should just be a rectangle for zero borderRadius
      expect(outerPath, isNotNull);
      expect(outerPath.getBounds(), rect);
    });

    test('getOuterPath should return rounded rect for non-zero borderRadius',
        () {
      const dottedBorder = DottedBorderShape(
        color: Colors.black,
        strokeWidth: 2.0,
        dashWidth: 2.0,
        dashSpace: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      );

      Rect rect = const Rect.fromLTWH(0, 0, 100, 50);
      Path outerPath = dottedBorder.getOuterPath(rect);

      // The outer path should be a rounded rectangle
      expect(outerPath, isNotNull);
      expect(outerPath.contains(const Offset(8.0, 8.0)), true);
      expect(outerPath.contains(const Offset(0, 0)), false);
    });

    test('getInnerPath should return deflated path', () {
      const dottedBorder = DottedBorderShape(
        color: Colors.black,
        strokeWidth: 4.0,
        dashWidth: 2.0,
        dashSpace: 2.0,
      );

      Rect rect = const Rect.fromLTWH(0, 0, 100, 50);
      Path innerPath = dottedBorder.getInnerPath(rect);

      // The inner path should be deflated by half the strokeWidth
      Rect expectedRect = rect.deflate(2.0); // strokeWidth / 2
      expect(innerPath.getBounds(), expectedRect);
    });

    test('scale should correctly scale border properties', () {
      const dottedBorder = DottedBorderShape(
        color: Colors.black,
        strokeWidth: 2.0,
        dashWidth: 2.0,
        dashSpace: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      );

      DottedBorderShape scaledBorder =
          dottedBorder.scale(2.0) as DottedBorderShape;

      // The strokeWidth, dashWidth, dashSpace, and borderRadius should all be scaled
      expect(scaledBorder.strokeWidth, 4.0);
      expect(scaledBorder.dashWidth, 4.0);
      expect(scaledBorder.dashSpace, 4.0);
      expect(scaledBorder.borderRadius,
          const BorderRadius.all(Radius.circular(8.0)));
    });
  });
}
