import 'package:core/widgets/form_input_code_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Default',
    type: ZbjFormInputCodeField,
    designLink:
        'https://www.figma.com/design/MtBXGXmFo8CcMmFmtHB1PP/Pati%C3%ABntenapp?node-id=1347-7049&node-type=frame',
    path: 'Core')
Widget buildDefaultUseCase(BuildContext context) {
  var error = context.knobs.stringOrNull(
      label: 'Error',
      initialValue: 'Vul alsjeblieft de hele code in om verder te gaan');
  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    alignment: Alignment.center,
    child: SafeArea(
      child: Form(
        key: GlobalKey<FormState>(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ZbjFormInputCodeField(
          fields: 6,
          validator: (val) {
            if (val == null || val.trim().length != 6) {
              return error;
            }
            return null;
          },
        ),
      ),
    ),
  );
}
