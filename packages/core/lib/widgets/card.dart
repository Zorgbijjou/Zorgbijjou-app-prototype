import 'package:core/widgets/outlined_focus.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

import '../styles/state_colors.dart';
import 'label.dart';

class ZbjCard extends md.StatefulWidget {
  final VoidCallback? onTap;
  final ZbjStateColors Function(BuildContext) backgroundColors;
  final Widget cardContentWidget;

  const ZbjCard._internal({
    this.onTap,
    required this.backgroundColors,
    required this.cardContentWidget,
  });

  factory ZbjCard.primary({
    Key? key,
    required String title,
    int titleMaxLines = 3,
    String? subTitle,
    md.Widget? body,
    ImageProvider<Object>? image,
    VoidCallback? onTap,
  }) {
    return ZbjCard._internal(
      onTap: onTap,
      backgroundColors: (context) => ZbjStateColors(
        defaultColor: context.tokens.color.tokensYellow50,
        activeColor: context.tokens.color.tokensYellow200,
        hoverColor: context.tokens.color.tokensYellow100,
        focusedColor: context.tokens.color.tokensYellow300,
      ),
      cardContentWidget: _PrimaryCardContent(
          title: title,
          titleMaxLines: titleMaxLines,
          subTitle: subTitle,
          body: body,
          image: image),
    );
  }

  factory ZbjCard.large({
    Key? key,
    required String title,
    int titleMaxLines = 3,
    String? subTitle,
    ZbjLabel? label,
    md.Widget? body,
    ImageProvider<Object>? image,
    VoidCallback? onTap,
  }) {
    return ZbjCard._internal(
      onTap: onTap,
      backgroundColors: (context) => ZbjStateColors(
        defaultColor: context.tokens.color.tokensTurqoise50,
        activeColor: context.tokens.color.tokensTurqoise200,
        hoverColor: context.tokens.color.tokensTurqoise100,
        focusedColor: context.tokens.color.tokensYellow300,
      ),
      cardContentWidget: _LargeCardContent(
        title: title,
        titleMaxLines: titleMaxLines,
        subTitle: subTitle,
        label: label,
        body: body,
        image: image,
      ),
    );
  }

  @override
  md.State<ZbjCard> createState() => _ZbjCardState();
}

class _ZbjCardState extends md.State<ZbjCard> {
  bool isFocused = false;
  var focusNode = FocusNode();

  @override
  md.Widget build(md.BuildContext context) {
    var borderRadius = BorderRadius.circular(8);
    var backgroundColors = widget.backgroundColors(context);

    return md.Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      color: backgroundColors.defaultColor,
      child: ZbjOutlinedFocus(
        borderRadius: borderRadius,
        focusNode: focusNode,
        builder: (context, showFocus) => md.Semantics(
          button: true,
          child: md.InkWell(
            borderRadius: borderRadius,
            highlightColor: backgroundColors.activeColor,
            splashColor: backgroundColors.activeColor,
            hoverColor: backgroundColors.hoverColor,
            focusColor: backgroundColors.focusedColor,
            focusNode: focusNode,
            onTap: widget.onTap,
            child: widget.cardContentWidget,
          ),
        ),
      ),
    );
  }
}

class _PrimaryCardContent extends md.StatelessWidget {
  final String title;
  final int titleMaxLines;
  final String? subTitle;
  final Widget? body;
  final ImageProvider<Object>? image;

  const _PrimaryCardContent({
    required this.title,
    required this.titleMaxLines,
    required this.subTitle,
    this.body,
    this.image,
  });

  @override
  md.Widget build(BuildContext context) {
    return md.IntrinsicHeight(
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 168.0,
        ),
        padding: const EdgeInsets.fromLTRB(16, 24, 0, 24),
        child: md.Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _CardContent(
                title: title,
                titleMaxLines: titleMaxLines,
                subTitle: subTitle,
                body: body,
              ),
            ),
            const md.SizedBox(width: 16),
            image != null ? _CardImage(image: image!) : const md.SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _LargeCardContent extends md.StatelessWidget {
  final String title;
  final int titleMaxLines;
  final String? subTitle;
  final ZbjLabel? label;
  final Widget? body;
  final ImageProvider<Object>? image;

  const _LargeCardContent({
    required this.title,
    required this.titleMaxLines,
    required this.subTitle,
    this.label,
    this.body,
    this.image,
  });

  @override
  md.Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: md.Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: md.MainAxisSize.min,
        children: [
          if (image != null) _LargeCardImage(image: image!),
          md.Padding(
            padding: const EdgeInsets.all(24),
            child: _CardContent(
              title: title,
              titleMaxLines: titleMaxLines,
              subTitle: subTitle,
              label: label,
              body: body,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final String title;
  final int titleMaxLines;
  final String? subTitle;
  final ZbjLabel? label;
  final Widget? body;

  const _CardContent({
    required this.title,
    required this.titleMaxLines,
    this.subTitle,
    this.label,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (label != null) label!,
        if (label != null) const SizedBox(height: 24),
        Text(
          title,
          maxLines: titleMaxLines,
          overflow: md.TextOverflow.ellipsis,
          style: context.tokens.textStyle.tokensTypographyHeadingMd,
        ),
        if (subTitle != null) const SizedBox(height: 8),
        if (subTitle != null)
          Text(
            subTitle!,
            style: context.tokens.textStyle.tokensTypographyParagraphSm,
          ),
        if (body != null) const SizedBox(height: 8),
        if (body != null) body!,
      ],
    );
  }
}

class _CardImage extends StatelessWidget {
  final ImageProvider<Object> image;

  const _CardImage({
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.fill,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(999),
            bottomLeft: Radius.circular(999),
          ),
        ),
      ),
    );
  }
}

class _LargeCardImage extends StatelessWidget {
  final ImageProvider<Object> image;

  const _LargeCardImage({
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return md.Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 174,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(999),
              bottomLeft: Radius.circular(999),
            ),
          ),
        ),
      ),
    );
  }
}
