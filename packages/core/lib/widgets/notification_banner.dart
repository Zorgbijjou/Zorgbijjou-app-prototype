import 'package:core/widgets/rich_text.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

class NotificationBanner extends StatefulWidget {
  final String title;
  final String content;
  final IconData? icon;
  final Color Function(BuildContext) backgroundColor;
  final Color Function(BuildContext) borderColor;
  final Color Function(BuildContext) iconColor;
  final bool closable;

  const NotificationBanner._({
    required this.title,
    required this.content,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    this.closable = false,
  });

  /// Negative banner factory
  factory NotificationBanner.negative({
    required String title,
    required String content,
    bool closable = false,
  }) {
    return NotificationBanner._(
      title: title,
      content: content,
      icon: CustomIcons.alert_octagon,
      backgroundColor: (context) => context.tokens.color.tokensRed50,
      borderColor: (context) => context.tokens.color.tokensRed600,
      iconColor: (context) => context.tokens.color.tokensRed600,
      closable: closable,
    );
  }

  /// Positive banner factory
  factory NotificationBanner.positive({
    required String title,
    required String content,
    bool closable = false,
  }) {
    return NotificationBanner._(
      title: title,
      content: content,
      icon: CustomIcons.check_circle,
      backgroundColor: (context) => context.tokens.color.tokensGreen50,
      borderColor: (context) => context.tokens.color.tokensGreen600,
      iconColor: (context) => context.tokens.color.tokensGreen600,
      closable: closable,
    );
  }

  @override
  State<NotificationBanner> createState() => _NotificationBannerState();
}

class _NotificationBannerState extends State<NotificationBanner>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;

  void _closeBanner() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
      child: _isVisible ? buildNotificationBanner() : const SizedBox.shrink(),
    );
  }

  buildNotificationBanner() {
    return Container(
      key: const ValueKey('NotificationBanner'), // For AnimatedSwitcher
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: widget.backgroundColor(context),
        border: Border.all(
          color: widget.borderColor(context),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Icon(
              widget.icon,
              size: 24,
              color: widget.iconColor(context),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: context.tokens.textStyle.tokensTypographyHeadingLg,
                  ),
                  const SizedBox(height: 8.0),
                  ZbjRichText(
                    text: widget.content,
                    overflow: TextOverflow.visible,
                    style: context.tokens.textStyle.tokensTypographyParagraphMd,
                  ),
                ],
              ),
            ),
          ),
          if (widget.closable)
            IconButton(
              icon: const Icon(CustomIcons.x),
              color: context.tokens.color.tokensGrey800,
              onPressed: _closeBanner,
              splashRadius: 16,
            ),
        ],
      ),
    );
  }
}
