import 'package:core/shapes/dotted_border_shape.dart';
import 'package:core/shapes/dotted_input_border_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DottedInputBorderShape', () {
    test('copyWith should return new instance with updated BorderSide', () {
      DottedBorderShape originalShape = const DottedBorderShape(
        color: Colors.black,
        strokeWidth: 2.0,
        dashWidth: 3.0,
        dashSpace: 3.0,
      );

      DottedInputBorderShape border =
          DottedInputBorderShape(dottedShape: originalShape);

      // Copy with new BorderSide
      DottedInputBorderShape updatedBorder = border.copyWith(
        borderSide: const BorderSide(color: Colors.red, width: 4.0),
      ) as DottedInputBorderShape;

      expect(updatedBorder.dottedShape.color, Colors.red);
      expect(updatedBorder.dottedShape.strokeWidth, 4.0);

      // Ensure that original dottedShape is not mutated
      expect(border.dottedShape.color, Colors.black);
      expect(border.dottedShape.strokeWidth, 2.0);
    });

    test('copyWith without BorderSide should return the same shape', () {
      DottedBorderShape originalShape = const DottedBorderShape(
        color: Colors.black,
        strokeWidth: 2.0,
        dashWidth: 3.0,
        dashSpace: 3.0,
      );
      DottedInputBorderShape border =
          DottedInputBorderShape(dottedShape: originalShape);

      // Call copyWith without passing a BorderSide
      DottedInputBorderShape newBorder =
          border.copyWith() as DottedInputBorderShape;

      // Expect the original and new shapes to be equal
      expect(newBorder.dottedShape, originalShape);
    });

    test('dimensions should return the dimensions of the dottedShape', () {
      DottedBorderShape dottedShape = const DottedBorderShape(
        color: Colors.black,
        strokeWidth: 4.0,
        dashWidth: 3.0,
        dashSpace: 3.0,
      );
      DottedInputBorderShape border =
          DottedInputBorderShape(dottedShape: dottedShape);

      expect(border.dimensions, const EdgeInsets.all(4.0));
    });

    test('getInnerPath should return inner path of dottedShape', () {
      DottedBorderShape dottedShape = const DottedBorderShape(
        color: Colors.black,
        strokeWidth: 2.0,
        dashWidth: 3.0,
        dashSpace: 3.0,
      );
      DottedInputBorderShape border =
          DottedInputBorderShape(dottedShape: dottedShape);

      Rect rect = const Rect.fromLTWH(0, 0, 100, 50);
      Path innerPath = border.getInnerPath(rect);

      expect(innerPath.getBounds(), dottedShape.getInnerPath(rect).getBounds());
    });

    test('getOuterPath should return outer path of dottedShape', () {
      DottedBorderShape dottedShape = const DottedBorderShape(
        color: Colors.black,
        strokeWidth: 2.0,
        dashWidth: 3.0,
        dashSpace: 3.0,
      );
      DottedInputBorderShape border =
          DottedInputBorderShape(dottedShape: dottedShape);

      Rect rect = const Rect.fromLTWH(0, 0, 100, 50);
      Path outerPath = border.getOuterPath(rect);

      expect(outerPath.getBounds(), dottedShape.getOuterPath(rect).getBounds());
    });

    test('scale should correctly scale the dottedShape', () {
      DottedBorderShape dottedShape = const DottedBorderShape(
        color: Colors.black,
        strokeWidth: 2.0,
        dashWidth: 3.0,
        dashSpace: 3.0,
      );
      DottedInputBorderShape border =
          DottedInputBorderShape(dottedShape: dottedShape);

      DottedInputBorderShape scaledBorder =
          border.scale(2.0) as DottedInputBorderShape;

      // Ensure that scale has scaled the dottedShape's properties
      expect(scaledBorder.dottedShape.strokeWidth, 4.0);
      expect(scaledBorder.dottedShape.dashWidth, 6.0);
      expect(scaledBorder.dottedShape.dashSpace, 6.0);
    });
  });
}
