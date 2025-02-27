import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class ZbjFormFieldErrorMessage extends StatelessWidget {
  const ZbjFormFieldErrorMessage({
    super.key,
    required this.errorText,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: context.tokens.color.tokensRed600,
        ),
        const SizedBox(width: 4.0),
        Flexible(
          child: Text(
            errorText,
            overflow: TextOverflow.visible,
            style: context.tokens.textStyle.tokensTypographyParagraphMd
                .copyWith(color: context.tokens.color.tokensRed600),
          ),
        ),
      ],
    );
  }
}
