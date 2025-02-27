import 'package:core/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/icons.dart';

@widgetbook.UseCase(
    name: 'Page Header - Sub Level',
    type: ZbjPageHeader,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildPageHeaderSubLevelUseCase(BuildContext context) {
  return Container(
      color: context.knobs.boolean(label: 'Inverted')
          ? context.tokens.color.tokensTurqoise600
          : context.tokens.color.tokensWhite,
      child: ZbjPageHeader.subLevel(
        title: context.knobs.string(
            label: 'Title',
            initialValue: 'Ik heb geen e-mail van Luscii gekregen, wat nu?'),
        subtitle: context.knobs.stringOrNull(
            label: 'Subtitle', initialValue: 'Laatst bijgewerkt: 8 juni 2024'),
        introduction: context.knobs.stringOrNull(
            label: 'Introduction',
            initialValue:
                'Heb je geen e-mail ontvangen? Dat is vervelend. We lossen dit stap voor stap met je op.'),
        icon: iconKnob(
          context: context,
          size: 32,
        ),
      ));
}

@widgetbook.UseCase(
    name: 'Page Header - First Level',
    type: ZbjPageHeader,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Zorg-bij-jou-Components?node-id=847-865&t=Mmpl3ODptnI6vseh-4',
    path: 'Core')
Widget buildPageHeaderFirstLevelUseCase(BuildContext context) {
  return Container(
      color: context.knobs.boolean(label: 'Inverted')
          ? context.tokens.color.tokensTurqoise600
          : context.tokens.color.tokensWhite,
      child: ZbjPageHeader.firstLevel(
        title: context.knobs.string(
            label: 'Title',
            initialValue: 'Ik heb geen e-mail van Luscii gekregen, wat nu?'),
        icon: iconKnob(
          context: context,
          size: 32,
        ),
        inverted: context.knobs.boolean(label: 'Inverted'),
      ));
}
