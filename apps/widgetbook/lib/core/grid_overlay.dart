import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Extra Small (xs)',
  type: GridOverlay,
  path: 'Core',
)
Widget buildExtraSmallGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 400,
    height: 800,
    child: const GridOverlay(),
  );
}

@widgetbook.UseCase(
  name: 'Small (sm)',
  type: GridOverlay,
  path: 'Core',
)
Widget buildSmallGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 600,
    height: 800,
    child: const GridOverlay(),
  );
}

@widgetbook.UseCase(
  name: 'Medium (md)',
  type: GridOverlay,
  path: 'Core',
)
Widget buildMediumGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 800,
    height: 800,
    child: const GridOverlay(),
  );
}

@widgetbook.UseCase(
  name: 'Large (lg)',
  type: GridOverlay,
  path: 'Core',
)
Widget buildLargeGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 1100,
    height: 800,
    child: const GridOverlay(),
  );
}

@widgetbook.UseCase(
  name: 'Extra Large (xl)',
  type: GridOverlay,
  path: 'Core',
)
Widget buildExtraLargeGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 1400,
    height: 800,
    child: const GridOverlay(),
  );
}
