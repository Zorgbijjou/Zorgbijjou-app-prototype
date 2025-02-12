import 'package:core/styles/colored_button_style.dart';
import 'package:core/widgets/appearance.dart';
import 'package:core/widgets/outlined_focus.dart';
import 'package:flutter/material.dart';

class ZbjIconButton extends StatefulWidget {
  final Appearance appearance;
  final Function() onPressed;
  final Widget icon;
  final String? tooltip;
  final FocusNode? focusNode; // Add this line

  const ZbjIconButton._internal({
    super.key,
    required this.appearance,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.focusNode, // Add this line
  });

  factory ZbjIconButton.brand({
    Key? key,
    required Function() onPressed,
    required Icon icon,
    tooltip,
    FocusNode? focusNode,
  }) {
    return ZbjIconButton._internal(
      appearance: Appearance.brand,
      onPressed: onPressed,
      icon: icon,
      tooltip: tooltip,
      focusNode: focusNode,
    );
  }

  factory ZbjIconButton.primary({
    Key? key,
    required Function() onPressed,
    required Widget icon,
    tooltip,
    FocusNode? focusNode,
  }) {
    return ZbjIconButton._internal(
      key: key,
      appearance: Appearance.primary,
      onPressed: onPressed,
      icon: icon,
      tooltip: tooltip,
      focusNode: focusNode,
    );
  }

  factory ZbjIconButton.secondary({
    Key? key,
    required Function() onPressed,
    required Widget icon,
    tooltip,
    FocusNode? focusNode,
  }) {
    return ZbjIconButton._internal(
      key: key,
      appearance: Appearance.secondary,
      onPressed: onPressed,
      icon: icon,
      tooltip: tooltip,
      focusNode: focusNode,
    );
  }

  factory ZbjIconButton.subtle({
    Key? key,
    required Function() onPressed,
    required Widget icon,
    tooltip,
    FocusNode? focusNode,
  }) {
    return ZbjIconButton._internal(
      key: key,
      appearance: Appearance.subtle,
      onPressed: onPressed,
      icon: icon,
      tooltip: tooltip,
      focusNode: focusNode,
    );
  }

  @override
  State<ZbjIconButton> createState() => _ZbjIconButtonState();
}

class _ZbjIconButtonState extends State<ZbjIconButton> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedFocus(
      focusNode: focusNode,
      borderRadius: BorderRadius.circular(24),
      builder: (context, showFocus) {
        return _buildIconButton(context);
      },
    );
  }

  Widget _buildIconButton(BuildContext context) {
    switch (widget.appearance) {
      case Appearance.brand:
        return _buildBrandIconButton(context);
      case Appearance.primary:
        return _buildPrimaryIconButton(context);
      case Appearance.secondary:
        return _buildSecondaryIconButton(context);
      case Appearance.subtle:
        return _buildSubtleIconButton(context);
    }
  }

  Widget _buildSubtleIconButton(BuildContext context) {
    var baseStyle = IconButton.styleFrom(
      fixedSize: const Size(48, 48),
    );

    var buttonStyle =
        ColoredButtonStyle.subtleButtonStyle(context).getButtonStyle(baseStyle);

    return IconButton(
      onPressed: widget.onPressed,
      style: buttonStyle,
      icon: widget.icon,
      tooltip: widget.tooltip,
      focusNode: focusNode,
    );
  }

  Widget _buildSecondaryIconButton(BuildContext context) {
    var baseStyle = IconButton.styleFrom(
      fixedSize: const Size(48, 48),
    );

    var buttonStyle = ColoredButtonStyle.secondaryButtonStyle(context)
        .getButtonStyle(baseStyle);

    return IconButton.outlined(
      onPressed: widget.onPressed,
      style: buttonStyle,
      icon: widget.icon,
      tooltip: widget.tooltip,
      focusNode: focusNode,
    );
  }

  Widget _buildPrimaryIconButton(BuildContext context) {
    var baseStyle = IconButton.styleFrom(
      fixedSize: const Size(48, 48),
    );

    var buttonStyle = ColoredButtonStyle.primaryButtonStyle(context)
        .getButtonStyle(baseStyle);

    return IconButton(
      onPressed: widget.onPressed,
      style: buttonStyle,
      icon: widget.icon,
      tooltip: widget.tooltip,
      focusNode: focusNode,
    );
  }

  Widget _buildBrandIconButton(BuildContext context) {
    var baseStyle = IconButton.styleFrom(
      fixedSize: const Size(48, 48),
    );

    var buttonStyle =
        ColoredButtonStyle.brandButtonStyle(context).getButtonStyle(baseStyle);

    return IconButton(
      onPressed: widget.onPressed,
      style: buttonStyle,
      icon: widget.icon,
      tooltip: widget.tooltip,
      focusNode: focusNode,
    );
  }
}
