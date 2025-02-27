import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

abstract class ZbjPageHeader {
  static ZbjFirstLevelPageHeader firstLevel({
    Key? key,
    required String title,
    Widget? icon,
    bool inverted = false,
    Widget? appBar,
  }) {
    return ZbjFirstLevelPageHeader(
      key: key,
      title: title,
      icon: icon,
      inverted: inverted,
      appBar: appBar,
    );
  }

  static ZbjSubLevelPageHeader subLevel({
    Key? key,
    required String title,
    String? subtitle,
    String? introduction,
    Widget? icon,
    Widget? avatar,
    Widget? appBar,
  }) {
    return ZbjSubLevelPageHeader(
      key: key,
      title: title,
      subtitle: subtitle,
      introduction: introduction,
      icon: icon,
      avatar: avatar,
      appBar: appBar,
    );
  }
}

class ZbjFirstLevelPageHeader extends StatelessWidget {
  final String title;
  final Widget? icon;
  final bool inverted;
  final Widget? appBar;

  const ZbjFirstLevelPageHeader({
    super.key,
    required this.title,
    this.icon,
    this.inverted = false,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return ZbjGridPadding(
      verticalPadding: 24,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          icon != null
              ? Padding(padding: const EdgeInsets.only(right: 12), child: icon)
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              title,
              style:
                  context.tokens.textStyle.tokensTypographyHeading2xl.copyWith(
                color: inverted
                    ? context.tokens.color.tokensWhite
                    : context.tokens.color.tokensGrey800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ZbjSubLevelPageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? introduction;
  final Widget? icon;
  final Widget? avatar;
  final bool inverted;
  final Widget? appBar;

  const ZbjSubLevelPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.introduction,
    this.icon,
    this.avatar,
    this.inverted = false,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.tokens.color.tokensWhite,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (appBar != null) appBar!,
          ZbjGridPadding(
            verticalPadding: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    icon != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: icon)
                        : const SizedBox(key: Key('empty_icon')),
                    avatar != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: avatar)
                        : const SizedBox(key: Key('empty_avatar')),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        title,
                        style: context
                            .tokens.textStyle.tokensTypographyHeadingLg
                            .copyWith(
                          color: inverted
                              ? context.tokens.color.tokensWhite
                              : context.tokens.color.tokensGrey800,
                        ),
                      ),
                    ),
                  ],
                ),
                if (subtitle != null) const SizedBox(height: 16),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: context.tokens.textStyle.tokensTypographyParagraphSm
                        .copyWith(
                            fontStyle: FontStyle.italic,
                            color: inverted
                                ? context.tokens.color.tokensWhite
                                : context.tokens.color.tokensGrey800),
                  ),
                if (introduction != null) const SizedBox(height: 16),
                if (introduction != null)
                  Text(
                    introduction!,
                    style: context.tokens.textStyle.tokensTypographyParagraphMd
                        .copyWith(
                            color: inverted
                                ? context.tokens.color.tokensWhite
                                : context.tokens.color.tokensGrey800),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
