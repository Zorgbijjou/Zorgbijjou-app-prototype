import 'package:core/styles/colored_button_style.dart';
import 'package:core/widgets/appearance.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

import 'outlined_focus.dart';

class StackedButton extends StatefulWidget {
  final String label;
  final Appearance appearance;
  final Function() onPressed;
  final bool fill;
  final Widget? icon;

  const StackedButton._internal({
    super.key,
    required this.label,
    required this.appearance,
    required this.onPressed,
    this.fill = false,
    required this.icon,
  });

  factory StackedButton.primary({
    Key? key,
    required String label,
    required Function() onPressed,
    bool fill = false,
    Widget? icon,
    FocusNode? focusNode,
  }) {
    return StackedButton._internal(
      key: key,
      appearance: Appearance.primary,
      label: label,
      onPressed: onPressed,
      fill: fill,
      icon: icon,
    );
  }

  @override
  State<StackedButton> createState() => _StackedButtonState();
}

class _StackedButtonState extends State<StackedButton> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return OutlinedFocus(
      focusNode: focusNode,
      borderRadius: BorderRadius.circular(8.0),
      builder: (context, showFocus) => _buildButton(context),
    );
  }

  Widget _buildButton(BuildContext context) {
    switch (widget.appearance) {
      case Appearance.brand:
      case Appearance.secondary:
      case Appearance.subtle:
      case Appearance.primary:
        return _buildPrimaryButton(context);
    }
  }

  TextButton _buildPrimaryButton(BuildContext context) {
    var baseStyle = TextButton.styleFrom(
      minimumSize:
          widget.fill ? const Size(double.infinity, 0) : const Size(88, 0),
      textStyle: context.tokens.textStyle.tokensTypographyParagraphBoldMd,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.centerLeft,
    );

    var buttonStyle = ColoredButtonStyle(context,
        foregroundColors: ForegroundColors(
          defaultColor: context.tokens.color.tokensTurqoise600,
          hoverColor: context.tokens.color.tokensTurqoise700,
          activeColor: context.tokens.color.tokensTurqoise800,
        ),
        backgroundColors: BackgroundColors(
          defaultColor: context.tokens.color.tokensWhite,
          hoverColor: context.tokens.color.tokensGrey100,
          activeColor: context.tokens.color.tokensGrey200,
        )).getButtonStyle(baseStyle);

    var textWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Text(widget.label));

    var iconWidget = widget.icon ?? const SizedBox();
    var container = Column(
      mainAxisSize: widget.fill ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [iconWidget, const SizedBox(height: 8), textWidget],
    );

    return TextButton(
      onPressed: widget.onPressed,
      style: buttonStyle,
      focusNode: focusNode,
      child: container,
    );
  }
}
