import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

abstract class CustomDivider extends StatelessWidget {
  const CustomDivider._();

  factory CustomDivider.standard() {
    return _PrimaryDivider(
        colorBuilder: (context) =>
            context.tokens.color.tokensWhite.withValues(alpha: 0.32));
  }

  factory CustomDivider.inverted() {
    return _PrimaryDivider(
        colorBuilder: (context) =>
            context.tokens.color.tokensGrey800.withValues(alpha: 0.32));
  }

  factory CustomDivider.label({required String label, required Color color}) {
    return _LabelDivider(label: label, color: color);
  }
}

class _PrimaryDivider extends CustomDivider {
  final Color Function(BuildContext) colorBuilder;

  const _PrimaryDivider({
    required this.colorBuilder,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      color: colorBuilder.call(context),
    );
  }
}

class _LabelDivider extends CustomDivider {
  final String label;
  final Color color;

  const _LabelDivider({
    required this.color,
    required this.label,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(child: Divider(height: 1, color: color)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          label,
          style: context.tokens.textStyle.tokensTypographyParagraphXs
              .copyWith(color: color),
        ),
      ),
      Expanded(child: Divider(height: 1, color: color)),
    ]);
  }
}
