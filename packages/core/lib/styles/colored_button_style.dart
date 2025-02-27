import 'package:core/styles/state_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class ZbjColoredButtonStyle extends ButtonStyle {
  final ZbjStateColors foregroundColors;
  final ZbjStateColors backgroundColors;
  final bool hasBorder;

  factory ZbjColoredButtonStyle.primaryButtonStyle(BuildContext context) {
    return ZbjColoredButtonStyle(
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

  factory ZbjColoredButtonStyle.secondaryButtonStyle(BuildContext context) {
    return ZbjColoredButtonStyle(
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

  factory ZbjColoredButtonStyle.subtleButtonStyle(BuildContext context) {
    return ZbjColoredButtonStyle(
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

  factory ZbjColoredButtonStyle.brandButtonStyle(BuildContext context) {
    return ZbjColoredButtonStyle(
      context,
      foregroundColors: ForegroundColors(defaultColor: Colors.white),
      backgroundColors: BackgroundColors(
        defaultColor: context.tokens.color.tokensOrange600,
        activeColor: context.tokens.color.tokensOrange800,
        hoverColor: context.tokens.color.tokensOrange700,
      ),
    );
  }

  ZbjColoredButtonStyle(
    BuildContext context, {
    this.hasBorder = false,
    required ForegroundColors foregroundColors,
    required BackgroundColors backgroundColors,
  })  : foregroundColors = ZbjStateColors(
          defaultColor: foregroundColors.defaultColor,
          activeColor: foregroundColors.activeColor,
          hoverColor: foregroundColors.hoverColor,
          // focused color the same for all styles
          focusedColor: context.tokens.color.tokensGrey800,
        ),
        backgroundColors = ZbjStateColors(
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

class ForegroundColors extends ZbjStateColors {
  ForegroundColors({
    required super.defaultColor,
    super.activeColor,
    super.hoverColor,
  });
}

class BackgroundColors extends ZbjStateColors {
  BackgroundColors({
    required super.defaultColor,
    super.activeColor,
    super.hoverColor,
  });
}
