import 'package:core/styles/state_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class ColoredButtonStyle extends ButtonStyle {
  final StateColors foregroundColors;
  final StateColors backgroundColors;
  final bool hasBorder;

  factory ColoredButtonStyle.primaryButtonStyle(BuildContext context) {
    return ColoredButtonStyle(
      context,
      foregroundColors: ForegroundColors(
        defaultColor: Colors.white,
      ),
      backgroundColors: BackgroundColors(
        defaultColor: context.tokens.color.tokensTurqoise600,
        activeColor: context.tokens.color.tokensTurqoise800,
        hoverColor: context.tokens.color.tokensTurqoise700,
      ),
    );
  }

  factory ColoredButtonStyle.secondaryButtonStyle(BuildContext context) {
    return ColoredButtonStyle(
      context,
      hasBorder: true,
      foregroundColors: ForegroundColors(
        defaultColor: context.tokens.color.tokensTurqoise600,
        activeColor: context.tokens.color.tokensTurqoise800,
        hoverColor: context.tokens.color.tokensTurqoise700,
      ),
      backgroundColors: BackgroundColors(
        defaultColor: Colors.white,
        activeColor: context.tokens.color.tokensGrey200,
        hoverColor: context.tokens.color.tokensGrey100,
      ),
    );
  }

  factory ColoredButtonStyle.subtleButtonStyle(BuildContext context) {
    return ColoredButtonStyle(
      context,
      foregroundColors: ForegroundColors(
        defaultColor: context.tokens.color.tokensTurqoise600,
        activeColor: context.tokens.color.tokensTurqoise800,
        hoverColor: context.tokens.color.tokensTurqoise700,
      ),
      backgroundColors: BackgroundColors(
        defaultColor: Colors.transparent,
        activeColor: context.tokens.color.tokensGrey200,
        hoverColor: context.tokens.color.tokensGrey100,
      ),
    );
  }

  factory ColoredButtonStyle.brandButtonStyle(BuildContext context) {
    return ColoredButtonStyle(
      context,
      foregroundColors: ForegroundColors(defaultColor: Colors.white),
      backgroundColors: BackgroundColors(
        defaultColor: context.tokens.color.tokensOrange600,
        activeColor: context.tokens.color.tokensOrange800,
        hoverColor: context.tokens.color.tokensOrange700,
      ),
    );
  }

  ColoredButtonStyle(
    BuildContext context, {
    this.hasBorder = false,
    required ForegroundColors foregroundColors,
    required BackgroundColors backgroundColors,
  })  : foregroundColors = StateColors(
          defaultColor: foregroundColors.defaultColor,
          activeColor: foregroundColors.activeColor,
          hoverColor: foregroundColors.hoverColor,
          // focused color the same for all styles
          focusedColor: context.tokens.color.tokensGrey800,
        ),
        backgroundColors = StateColors(
          defaultColor: backgroundColors.defaultColor,
          activeColor: backgroundColors.activeColor,
          hoverColor: backgroundColors.hoverColor,
          // focused color the same for all styles
          focusedColor: context.tokens.color.tokensYellow300,
        );

  ButtonStyle getButtonStyle(ButtonStyle baseStyle) {
    return baseStyle.copyWith(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        return foregroundColors.getColorForWidgetState(states);
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return backgroundColors.defaultColor;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        return backgroundColors.getColorForWidgetState(states);
      }),
      side: WidgetStateProperty.resolveWith(
        (states) {
          if (!hasBorder) {
            return BorderSide.none;
          }
          var widgetStateColor =
              foregroundColors.getColorForWidgetState(states);
          return BorderSide(
            color: widgetStateColor,
            width: 2,
          );
        },
      ),
    );
  }
}

class ForegroundColors extends StateColors {
  ForegroundColors({
    required super.defaultColor,
    super.activeColor,
    super.hoverColor,
  });
}

class BackgroundColors extends StateColors {
  BackgroundColors({
    required super.defaultColor,
    super.activeColor,
    super.hoverColor,
  });
}
