import 'package:core/widgets/rich_text.dart';
import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Default',
    type: ZbjRichText,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Pill-Components?node-id=9509-4628&t=d4pVCOhWHA8dSxo0-0',
    path: 'Core')
Widget buildDefaultUseCase(BuildContext context) {
  return ZbjRichText(
    text: context.knobs.string(
      label: 'text',
      initialValue:
          'Controleer of je de code en je geboortedatum goed hebt ingevuld en probeer het opnieuw. Werkt het nog steeds niet? Bel dan het Medisch Service Centrum op +31 6 0192837.',
    ),
    style: context.tokens.textStyle.tokensTypographyParagraphMd,
  );
}
