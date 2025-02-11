import 'package:core/widgets/form_input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Default',
    type: ZbjFormInputTextField,
    designLink:
        'https://www.figma.com/design/Vg3ewXzIdLINWXMKMe14yN/Pill-Components?node-id=1155-3846&t=r5JjKFzy87us5NZS-0',
    path: 'Core')
Widget buildDefaultUseCase(BuildContext context) {
  var accessibleLabel =
      context.knobs.string(label: 'AccessibleLabel', initialValue: '''Field''');
  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    alignment: Alignment.center,
    child: SafeArea(
      child: Form(
        key: GlobalKey<FormState>(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ZbjFormInputTextField(
          controller: TextEditingController(),
          focusNode: FocusNode(),
          accessibleLabel: accessibleLabel,
        ),
      ),
    ),
  );
}
