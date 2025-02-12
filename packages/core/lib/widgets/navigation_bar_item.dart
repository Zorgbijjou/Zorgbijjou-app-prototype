import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

import 'outlined_focus.dart';

class ZbjNavigationBarItemWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final ValueChanged<int> onDestinationSelected;
  final int index;
  final int totalItems;
  final bool showNotificationBubble;

  const ZbjNavigationBarItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onDestinationSelected,
    required this.index,
    required this.totalItems,
    required this.showNotificationBubble,
  });

  @override
  ZbjNavigationBarItemWidgetState createState() =>
      ZbjNavigationBarItemWidgetState();
}

class ZbjNavigationBarItemWidgetState
    extends State<ZbjNavigationBarItemWidget> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var indexNumber = widget.index + 1;

    return Container(
      decoration: BoxDecoration(
        color: widget.isSelected
            ? context.tokens.color.tokensTurqoise50
            : Colors.transparent,
        border: widget.isSelected
            ? Border(
                top: BorderSide(
                  color: context.tokens.color.tokensTurqoise700,
                  width: 4,
                ),
              )
            : Border(
                top: BorderSide(
                  color: context.tokens.color.tokensGrey200,
                  width: 1,
                ),
              ),
      ),
      child: Material(
        color: Colors.transparent,
        child: OutlinedFocus(
          focusNode: focusNode,
          builder: (context, showFocus) => Semantics(
            label:
                '${widget.label}\nTab $indexNumber van de ${widget.totalItems}',
            selected: widget.isSelected,
            excludeSemantics: true,
            child: InkWell(
              focusNode: focusNode,
              onTap: () => widget.onDestinationSelected(widget.index),
              highlightColor: widget.isSelected
                  ? context.tokens.color.tokensTurqoise50
                  : Colors.transparent,
              splashColor: context.tokens.color.tokensTurqoise100,
              hoverColor: context.tokens.color.tokensTurqoise50,
              focusColor: context.tokens.color.tokensYellow300,
              child: Padding(
                padding: EdgeInsets.only(top: widget.isSelected ? 0 : 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Icon(
                          widget.icon,
                          color: context.tokens.color.tokensTurqoise800,
                        ),
                        if (widget.showNotificationBubble)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: context.tokens.color.tokensRed400,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.label,
                      style: context.tokens.textStyle.tokensTypographyHeadingSm
                          .copyWith(
                        color: context.tokens.color.tokensTurqoise800,
                        fontWeight: widget.isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
