import 'package:core/widgets/outlined_focus.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

enum ZbjListItemPosition { first, middle, last }

extension ZbjPositionCalculation<T> on Iterable<T> {
  ZbjListItemPosition getListItemPosition(T item) {
    if (first == item) {
      return ZbjListItemPosition.first;
    }

    if (last == item) {
      return ZbjListItemPosition.last;
    }

    return ZbjListItemPosition.middle;
  }
}

class ZbjListItem extends StatefulWidget {
  final String title;
  final bool inverted;
  final ZbjListItemPosition position;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final IconData icon;

  const ZbjListItem({
    super.key,
    required this.title,
    this.onTap,
    this.inverted = false,
    this.position = ZbjListItemPosition.middle,
    this.focusNode,
    this.icon = Icons.arrow_forward_rounded,
  });

  @override
  State<ZbjListItem> createState() => _ZbjListItemState();
}

class _ZbjListItemState extends State<ZbjListItem> {
  var focusNode = FocusNode();
  var isHovered = false;
  var isHighlighted = false;

  onHoverChanged(value) {
    setState(() {
      isHovered = value;
    });
  }

  onHighlightChanged(value) {
    setState(() {
      isHovered = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZbjOutlinedFocus(
      focusNode: focusNode,
      builder: (context, showFocus) => Semantics(
        button: true,
        child: InkWell(
          onTap: widget.onTap,
          highlightColor: widget.inverted
              ? context.tokens.color.tokensWhite.withValues(alpha: 0.05)
              : context.tokens.color.tokensGrey800.withValues(alpha: 0.1),
          splashColor: widget.inverted
              ? context.tokens.color.tokensWhite.withValues(alpha: 0.05)
              : context.tokens.color.tokensGrey800.withValues(alpha: 0.1),
          hoverColor: widget.inverted
              ? context.tokens.color.tokensWhite.withValues(alpha: 0.1)
              : context.tokens.color.tokensGrey800.withValues(alpha: 0.2),
          focusColor: context.tokens.color.tokensYellow300,
          onHover: onHoverChanged,
          onHighlightChanged: onHighlightChanged,
          focusNode: focusNode,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              widget.position == ZbjListItemPosition.first ? 0 : 24,
              0,
              widget.position == ZbjListItemPosition.last ? 0 : 24,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: context.tokens.textStyle.tokensTypographyParagraphMd
                        .copyWith(
                      decorationColor: getContentColor(context, showFocus),
                      decoration: isHovered || isHighlighted
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      color: getContentColor(context, showFocus),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  size: 24,
                  widget.icon,
                  color: getContentColor(context, showFocus),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getContentColor(BuildContext context, bool isFocused) {
    if (isFocused) {
      return context.tokens.color.tokensGrey800;
    }

    return widget.inverted
        ? context.tokens.color.tokensWhite
        : context.tokens.color.tokensTurqoise600;
  }
}
