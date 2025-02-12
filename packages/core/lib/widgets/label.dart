import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class Label extends StatelessWidget {
  final String label;
  final IconData? icon;

  const Label({super.key, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.tokens.color.tokensWhite,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: 16),
          if (icon != null) const SizedBox(width: 8),
          SizedBox(
            height: 16,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: context.tokens.textStyle.tokensTypographyParagraphXs,
            ),
          ),
        ],
      ),
    );
  }
}
