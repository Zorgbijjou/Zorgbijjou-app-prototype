import 'package:core/styles/colored_button_style.dart';
import 'package:core/widgets/appearance.dart';
import 'package:core/widgets/outlined_focus.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class Button extends StatefulWidget {
  final String label;
  final ZbjAppearance appearance;
  final Function() onPressed;
  final bool cropped;
  final bool fill;
  final Widget? icon;
  final IconAlignment iconAlignment;

  const Button._internal({
    super.key,
    required this.label,
    required this.appearance,
    required this.onPressed,
    this.cropped = false,
    this.fill = false,
    this.icon,
    this.iconAlignment = IconAlignment.start,
  });

  factory Button.brand({
    Key? key,
    required String label,
    required Function() onPressed,
    bool fill = false,
    Widget? icon,
    IconAlignment? iconAlignment,
  }) {
    return Button._internal(
      label: label,
      appearance: ZbjAppearance.brand,
      onPressed: onPressed,
      fill: fill,
      icon: icon,
      iconAlignment: iconAlignment ?? IconAlignment.start,
    );
  }

  factory Button.primary({
    Key? key,
    required String label,
    required Function() onPressed,
    bool fill = false,
    Widget? icon,
    IconAlignment? iconAlignment,
  }) {
    return Button._internal(
      key: key,
      appearance: ZbjAppearance.primary,
      label: label,
      onPressed: onPressed,
      fill: fill,
      icon: icon,
      iconAlignment: iconAlignment ?? IconAlignment.start,
    );
  }

  factory Button.secondary({
    Key? key,
    required String label,
    required Function() onPressed,
    bool fill = false,
    Widget? icon,
    IconAlignment? iconAlignment,
  }) {
    return Button._internal(
      key: key,
      label: label,
      appearance: ZbjAppearance.secondary,
      onPressed: onPressed,
      fill: fill,
      icon: icon,
      iconAlignment: iconAlignment ?? IconAlignment.start,
    );
  }

  factory Button.subtle({
    Key? key,
    required String label,
    required Function() onPressed,
    bool cropped = false,
    bool fill = false,
    Widget? icon,
    IconAlignment? iconAlignment,
  }) {
    return Button._internal(
      key: key,
      label: label,
      appearance: ZbjAppearance.subtle,
      onPressed: onPressed,
      cropped: cropped,
      fill: fill,
      icon: icon,
      iconAlignment: iconAlignment ?? IconAlignment.start,
    );
  }

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ZbjOutlinedFocus(
      focusNode: focusNode,
      borderRadius: BorderRadius.circular(24),
      builder: (context, showFocus) {
        return _buildButton(context);
      },
    );
  }

  Widget _buildButton(BuildContext context) {
    switch (widget.appearance) {
      case ZbjAppearance.brand:
        return _buildBrandButton(context);
      case ZbjAppearance.primary:
        return _buildPrimaryButton(context);
      case ZbjAppearance.secondary:
        return _buildSecondaryButton(context);
      case ZbjAppearance.subtle:
        return _buildSubtleButton(context);
    }
  }

  TextButton _buildSubtleButton(BuildContext context) {
    var baseStyle = TextButton.styleFrom(
      minimumSize: widget.fill ? const Size(double.infinity, 0) : null,
      textStyle: context.tokens.textStyle.tokensTypographyHeadingMd,
      padding: EdgeInsets.symmetric(
          horizontal: widget.cropped ? 0 : 24, vertical: 0),
    );

    var buttonStyle = ZbjColoredButtonStyle.subtleButtonStyle(context)
        .getButtonStyle(baseStyle);

    var textWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        child: Text(widget.label));

    return widget.icon == null
        ? TextButton(
            onPressed: widget.onPressed,
            style: buttonStyle,
            focusNode: focusNode,
            child: textWidget,
          )
        : TextButton.icon(
            onPressed: widget.onPressed,
            label: textWidget,
            style: buttonStyle,
            icon: widget.icon,
            iconAlignment: widget.iconAlignment,
            focusNode: focusNode,
          );
  }

  OutlinedButton _buildSecondaryButton(BuildContext context) {
    var baseStyle = OutlinedButton.styleFrom(
      minimumSize: widget.fill ? const Size(double.infinity, 0) : null,
      textStyle: context.tokens.textStyle.tokensTypographyHeadingMd,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
    );

    var buttonStyle = ZbjColoredButtonStyle.secondaryButtonStyle(context)
        .getButtonStyle(baseStyle);

    var textWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        child: Text(widget.label));

    return widget.icon == null
        ? OutlinedButton(
            onPressed: widget.onPressed,
            style: buttonStyle,
            focusNode: focusNode,
            child: textWidget,
          )
        : OutlinedButton.icon(
            onPressed: widget.onPressed,
            label: textWidget,
            style: buttonStyle,
            icon: widget.icon,
            iconAlignment: widget.iconAlignment,
            focusNode: focusNode,
          );
  }

  FilledButton _buildPrimaryButton(BuildContext context) {
    var baseStyle = FilledButton.styleFrom(
      minimumSize: widget.fill ? const Size(double.infinity, 0) : null,
      textStyle: context.tokens.textStyle.tokensTypographyHeadingMd,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
    );

    var buttonStyle = ZbjColoredButtonStyle.primaryButtonStyle(context)
        .getButtonStyle(baseStyle);

    var textWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        child: Text(widget.label));

    return widget.icon == null
        ? FilledButton(
            onPressed: widget.onPressed,
            style: buttonStyle,
            focusNode: focusNode,
            child: textWidget,
          )
        : FilledButton.icon(
            onPressed: widget.onPressed,
            label: textWidget,
            style: buttonStyle,
            icon: widget.icon,
            iconAlignment: widget.iconAlignment,
            focusNode: focusNode,
          );
  }

  FilledButton _buildBrandButton(BuildContext context) {
    var baseStyle = FilledButton.styleFrom(
      minimumSize: widget.fill ? const Size(double.infinity, 0) : null,
      textStyle: context.tokens.textStyle.tokensTypographyHeadingMd,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
    );

    var buttonStyle = ZbjColoredButtonStyle.brandButtonStyle(context)
        .getButtonStyle(baseStyle);

    var textWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        child: Text(widget.label));

    return widget.icon == null
        ? FilledButton(
            onPressed: widget.onPressed,
            style: buttonStyle,
            focusNode: focusNode,
            child: textWidget,
          )
        : FilledButton.icon(
            onPressed: widget.onPressed,
            style: buttonStyle,
            label: textWidget,
            icon: widget.icon,
            iconAlignment: widget.iconAlignment,
            focusNode: focusNode,
          );
  }
}
