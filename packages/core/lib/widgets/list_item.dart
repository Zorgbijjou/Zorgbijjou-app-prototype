import 'package:core/widgets/outlined_focus.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

enum ListItemPosition { first, middle, last }

extension PositionCalculation<T> on Iterable<T> {
  ListItemPosition getListItemPosition(T item) {
    if (first == item) {
      return ListItemPosition.first;
    }

    if (last == item) {
      return ListItemPosition.last;
    }

    return ListItemPosition.middle;
  }
}

class ListItem extends StatefulWidget {
  final String title;
  final bool inverted;
  final ListItemPosition position;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final IconData icon;

  const ListItem({
    super.key,
    required this.title,
    this.onTap,
    this.inverted = false,
    this.position = ListItemPosition.middle,
    this.focusNode,
    this.icon = Icons.arrow_forward_rounded,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
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
    return OutlinedFocus(
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
              widget.position == ListItemPosition.first ? 0 : 24,
              0,
              widget.position == ListItemPosition.last ? 0 : 24,
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
