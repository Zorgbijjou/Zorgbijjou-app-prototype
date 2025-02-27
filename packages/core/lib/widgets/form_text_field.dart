import 'package:core/widgets/outlined_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme/theme.dart';

class ZbjFormTextField extends StatelessWidget {
  const ZbjFormTextField({
    super.key,
    required this.controller,
    required this.accessibleLabel,
    this.inputFormatters,
    this.hint,
    this.hasError,
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
    this.width,
  });

  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final bool? hasError;
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
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ZbjOutlinedFocus(
      suppressOutlineFocus: suppressOutlineFocus,
      focusNode: focusNode,
      borderRadius: BorderRadius.circular(8),
      builder: (context, showFocus) => buildInput(context),
    );
  }

  Widget buildInput(BuildContext context) {
    return Semantics(
      value: accessibleValue ?? controller.text,
      label: accessibleLabel,
      textField: true,
      enabled: true,
      excludeSemantics: true,
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        textAlign: textAlign,
        focusNode: focusNode,
        autofocus: autoFocus,
        maxLines: maxLines,
        minLines: minLines,
        onFieldSubmitted: onFieldSubmitted,
        style: context.tokens.textStyle.tokensTypographyParagraphMd.copyWith(
          color: context.tokens.color.tokensGrey800,
        ),
        decoration: InputDecoration(
          hintText: hint,
          errorText: null,
          error: hasError ?? false ? const SizedBox() : null,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 2,
              color: context.tokens.color.tokensRed600,
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 14,
            left: 12,
            right: 12,
            bottom: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: suppressOutlineFocus ? 1 : 2,
              color: suppressOutlineFocus
                  ? context.tokens.color.tokensGrey400
                  : context.tokens.color.tokensGrey800,
            ),
          ),
        ),
      ),
    );
  }
}
