// custom simpel Flutter app bar stateless with go back button only with a custom icon and text, use the existing app bar

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/icons/custom_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onPressed;

  const CustomAppBar({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(bottom: 16),
          child: Button.subtle(
            label: 'Terug',
            onPressed: onPressed,
            icon: const Icon(CustomIcons.arrow_left),
          )),
    );
  }

  // custom toolbar height
  final double _toolbarHeight = 96.0;

  @override
  Size get preferredSize => Size.fromHeight(_toolbarHeight);
}
