import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Extra Small (xs)',
  type: ZbjGridOverlay,
  path: 'Core',
)
Widget buildExtraSmallGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 400,
    height: 800,
    child: const ZbjGridOverlay(),
  );
}

@widgetbook.UseCase(
  name: 'Small (sm)',
  type: ZbjGridOverlay,
  path: 'Core',
)
Widget buildSmallGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 600,
    height: 800,
    child: const ZbjGridOverlay(),
  );
}

@widgetbook.UseCase(
  name: 'Medium (md)',
  type: ZbjGridOverlay,
  path: 'Core',
)
Widget buildMediumGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 800,
    height: 800,
    child: const ZbjGridOverlay(),
  );
}

@widgetbook.UseCase(
  name: 'Large (lg)',
  type: ZbjGridOverlay,
  path: 'Core',
)
Widget buildLargeGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 1100,
    height: 800,
    child: const ZbjGridOverlay(),
  );
}

@widgetbook.UseCase(
  name: 'Extra Large (xl)',
  type: ZbjGridOverlay,
  path: 'Core',
)
Widget buildExtraLargeGridOverlayUseCase(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 1400,
    height: 800,
    child: const ZbjGridOverlay(),
  );
}
