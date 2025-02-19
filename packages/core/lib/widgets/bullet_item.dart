import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

enum BulletType { bullet, icon, extra }

class BulletItem extends StatelessWidget {
  final BulletType type;
  final String label;
  final String? title;
  final Widget? icon;
  final Color? iconBackgroundColor;

  const BulletItem({
    super.key,
    required this.type,
    required this.label,
    this.title,
    this.icon,
    this.iconBackgroundColor,
  });

  factory BulletItem.icon({
    required String label,
    required Widget icon,
  }) {
    return BulletItem(type: BulletType.icon, label: label, icon: icon);
  }

  factory BulletItem.bullet({
    required String label,
  }) {
    return BulletItem(type: BulletType.bullet, label: label);
  }

  factory BulletItem.extra({
    required String label,
    required Widget icon,
    required Color iconBackgroundColor,
    String? title,
  }) {
    return BulletItem(
      type: BulletType.extra,
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
      case BulletType.bullet:
        return const Text('•');
      case BulletType.icon:
        return icon!;
      case BulletType.extra:
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
      case BulletType.bullet:
      case BulletType.icon:
        return 8;
      case BulletType.extra:
        return 12;
    }
  }

  double getTopPadding() {
    switch (type) {
      case BulletType.bullet:
      case BulletType.icon:
        return 0;
      case BulletType.extra:
        return 12;
    }
  }
}
