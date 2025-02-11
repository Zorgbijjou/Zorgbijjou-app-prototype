import 'package:flutter/material.dart';

class StateColors {
  final Color defaultColor;
  final Color? activeColor;
  final Color? hoverColor;
  final Color? focusedColor;

  const StateColors({
    required this.defaultColor,
    this.activeColor,
    this.hoverColor,
    this.focusedColor,
  });

  Color getColorForWidgetState(Set<WidgetState> state) {
    if (state.contains(WidgetState.focused) && focusedColor != null) {
      return focusedColor!;
    }

    if (state.contains(WidgetState.pressed) && activeColor != null) {
      return activeColor!;
    }

    if (state.contains(WidgetState.hovered) && hoverColor != null) {
      return hoverColor!;
    }

    return defaultColor;
  }
}
