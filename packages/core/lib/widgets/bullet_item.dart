import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

enum ZbjBulletType { bullet, icon, extra }

class ZbjBulletItem extends StatelessWidget {
  final ZbjBulletType type;
  final String label;
  final String? title;
  final Widget? icon;
  final Color? iconBackgroundColor;

  const ZbjBulletItem({
    super.key,
    required this.type,
    required this.label,
    this.title,
    this.icon,
    this.iconBackgroundColor,
  });

  factory ZbjBulletItem.icon({
    required String label,
    required Widget icon,
  }) {
    return ZbjBulletItem(type: ZbjBulletType.icon, label: label, icon: icon);
  }

  factory ZbjBulletItem.bullet({
    required String label,
  }) {
    return ZbjBulletItem(type: ZbjBulletType.bullet, label: label);
  }

  factory ZbjBulletItem.extra({
    required String label,
    required Widget icon,
    required Color iconBackgroundColor,
    String? title,
  }) {
    return ZbjBulletItem(
      type: ZbjBulletType.extra,
      title: title,
      label: label,
      icon: icon,
      iconBackgroundColor: iconBackgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildIconContainer(),
        SizedBox(width: gap()),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getTopPadding()),
              buildTitle(context),
              Text(
                label,
                style: context.tokens.textStyle.tokensTypographyParagraphMd,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    if (title == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title!,
        style: context.tokens.textStyle.tokensTypographyHeadingMd,
      ),
    );
  }

  Widget buildIconContainer() {
    switch (type) {
      case ZbjBulletType.bullet:
        return const Text('•');
      case ZbjBulletType.icon:
        return icon!;
      case ZbjBulletType.extra:
        return Container(
          decoration: BoxDecoration(
            color: iconBackgroundColor,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(12),
          child: icon,
        );
    }
  }

  double? gap() {
    switch (type) {
      case ZbjBulletType.bullet:
      case ZbjBulletType.icon:
        return 8;
      case ZbjBulletType.extra:
        return 12;
    }
  }

  double getTopPadding() {
    switch (type) {
      case ZbjBulletType.bullet:
      case ZbjBulletType.icon:
        return 0;
      case ZbjBulletType.extra:
        return 12;
    }
  }
}
