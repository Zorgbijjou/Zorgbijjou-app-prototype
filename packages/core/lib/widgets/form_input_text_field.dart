import 'package:core/widgets/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'form_field_error_message.dart';

class ZbjFormInputTextField extends StatelessWidget {
  const ZbjFormInputTextField({
    super.key,
    required this.controller,
    required this.accessibleLabel,
    this.inputFormatters,
    this.validator,
    this.hint,
    this.accessibleValue,
    this.onChanged,
    this.onFieldSubmitted,
    required this.focusNode,
    this.autoFocus = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.minLines = 1,
    this.suppressOutlineFocus = false,
    this.inputWidth,
  });

  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator? validator;
  final String? hint;
  final String accessibleLabel;
  final String? accessibleValue;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final FocusNode focusNode;
  final bool autoFocus;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextAlign textAlign;
  final int maxLines;
  final int minLines;
  final bool suppressOutlineFocus;
  final double? inputWidth;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (_) => validateControllerText(),
      builder: (FormFieldState<String> field) {
        _onResetErrorWhenFocusChange(field);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (field.hasError && field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: FormFieldErrorMessage(errorText: field.errorText!),
              ),
            SizedBox(
              width: inputWidth,
              child: ZbjFormTextField(
                focusNode: focusNode,
                controller: controller,
                inputFormatters: inputFormatters,
                hint: hint,
                accessibleLabel: accessibleLabel,
                accessibleValue: accessibleValue,
                autocorrect: autocorrect,
                enableSuggestions: enableSuggestions,
                textAlign: textAlign,
                hasError: field.hasError,
                onChanged: onChanged,
                onFieldSubmitted: (value) {
                  focusNode.unfocus();
                  onFieldSubmitted?.call(value);
                },
                autoFocus: autoFocus,
                maxLines: maxLines,
                minLines: minLines,
                suppressOutlineFocus: suppressOutlineFocus,
              ),
            ),
          ],
        );
      },
    );
  }

  void _onResetErrorWhenFocusChange(FormFieldState<String> field) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        field.reset();
      }
    });
  }

  String? validateControllerText() {
    if (validator == null) return null;
    var valid = validator!.call(controller.text);
    return valid;
  }
}
