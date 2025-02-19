import 'package:core/l10n/core_localizations.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

enum AvatarSize {
  small,
  medium,
}

var _avatarSpecs = {
  AvatarSize.small: (
    size: 40.0,
    padding: const EdgeInsets.only(top: 8, bottom: 2),
  ),
  AvatarSize.medium: (
    size: 48.0,
    padding: const EdgeInsets.only(top: 12, bottom: 6),
  )
};

class AvatarComponent extends StatelessWidget {
  final AvatarSize size;
  final String? name;
  final ImageProvider? image;

  const AvatarComponent._internal({
    super.key,
    required this.name,
    required this.size,
    this.image,
  });

  factory AvatarComponent.small({
    Key? key,
    String? name,
    ImageProvider? image,
  }) {
    return AvatarComponent._internal(
      key: key,
      name: name,
      size: AvatarSize.small,
      image: image,
    );
  }

  factory AvatarComponent.medium({
    Key? key,
    String? name,
    ImageProvider? image,
  }) {
    return AvatarComponent._internal(
      key: key,
      name: name,
      size: AvatarSize.medium,
      image: image,
    );
  }

  String _getInitials(String name) {
    var parts = name.split(' ');
    var initials = parts
        .where((String? part) => part != null && part.isNotEmpty)
        .map((part) => part[0].toUpperCase());

    if (initials.isEmpty) {
      return '';
    }

    if (initials.length == 1) {
      return initials.first;
    }

    return '${initials.first}${initials.last}';
  }

  @override
  Widget build(BuildContext context) {
    var spec = _avatarSpecs[size]!;
    return Semantics(
      label: AppLocalizations.of(context)!
          .conversationAvatarSemanticLabel(name ?? ''),
      excludeSemantics: true,
      child: Container(
        width: spec.size,
        height: spec.size,
        padding: spec.padding,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: context.tokens.color.tokensYellow200,
          image: image != null
              ? DecorationImage(
                  image: image!,
                  fit: BoxFit.fill,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
          ),
        ),
        child: name != null
            ? Center(
                child: Text(
                  _getInitials(name!),
                  textAlign: TextAlign.center,
                  style: context
                      .tokens.textStyle.tokensTypographyParagraphBoldLg
                      .copyWith(color: context.tokens.color.tokensYellow800),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
