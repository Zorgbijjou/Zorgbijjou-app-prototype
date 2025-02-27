import 'dart:math';

import 'package:core/widgets/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

import 'form_field_error_message.dart';

class ZbjFormInputCodeField extends FormField<String> {
  final TextEditingController? controller;
  final VoidCallback? onComplete;
  final VoidCallback? onSubmitted;

  ZbjFormInputCodeField({
    super.key,
    required int fields,
    super.onSaved,
    super.validator,
    this.controller,
    this.onComplete,
    this.onSubmitted,
  }) : super(
          initialValue: controller?.text ?? '',
          builder: (FormFieldState<String> state) {
            return _CodeInputField(
              fields: fields,
              state: state,
              controller: controller,
              onComplete: onComplete,
              onSubmitted: onSubmitted,
            );
          },
        );
}

class _CodeInputField extends StatefulWidget {
  final int fields;
  final FormFieldState<String> state;
  final TextEditingController? controller;
  final VoidCallback? onComplete;
  final VoidCallback? onSubmitted;

  const _CodeInputField({
    required this.state,
    required this.fields,
    required this.controller,
    required this.onComplete,
    required this.onSubmitted,
  });

  @override
  State<_CodeInputField> createState() => _CodeInputFieldState();
}

class _CodeInputFieldState extends State<_CodeInputField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late final List<String> _previousValues;
  String? _previousCombinedValue;
  final String emptyFieldValue = ' ';

  @override
  void initState() {
    super.initState();
    _initializeControllersAndFocusNodes();
    _addControllerListeners();
  }

  @override
  void dispose() {
    _controllers.map((controller) => controller.dispose());
    _focusNodes.map((focusNode) => focusNode.dispose());
    super.dispose();
  }

  void _initializeControllersAndFocusNodes() {
    _controllers =
        List.generate(widget.fields, _initializeTextEditingControllerForIndex);

    _focusNodes = List.generate(widget.fields, _createFocusNodeForIndex);

    _previousValues = List.generate(widget.fields, (index) => '');
  }

  void _addControllerListeners() {
    for (var controller in _controllers) {
      controller.addListener(_updateValue);
      controller.addListener(
        () => _onListenToControllerChangedToEmpty(controller),
      );
      controller.addListener(() {
        var text = controller.text.toUpperCase();
        if (controller.text != text) {
          controller.value = controller.value.copyWith(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
          );
        }
      });
    }
  }

  _CodeInputFieldChange determineFieldChange(TextEditingController controller) {
    int index = _controllers.indexOf(controller);

    var previousValue = _previousValues[index];
    var newValue = controller.text;

    if (previousValue.isEmpty && newValue.isEmpty) {
      return _CodeInputFieldChange.initial;
    }

    if (previousValue == newValue) {
      return _CodeInputFieldChange.unchanged;
    }

    if (previousValue.isEmpty && newValue == emptyFieldValue) {
      return _CodeInputFieldChange.unchanged;
    }

    if (previousValue == emptyFieldValue && newValue.isEmpty) {
      return _CodeInputFieldChange.emptyFieldBackspace;
    }

    if (previousValue != emptyFieldValue && newValue.isEmpty) {
      return _CodeInputFieldChange.fieldBackspace;
    }

    if (previousValue != controller.text) {
      return _CodeInputFieldChange.fieldChange;
    }

    throw Exception(
        'Unknown field change - "$previousValue", "${controller.text}"');
  }

  void _onListenToControllerChangedToEmpty(TextEditingController controller) {
    int index = _controllers.indexOf(controller);

    var change = determineFieldChange(controller);

    if (change == _CodeInputFieldChange.initial) {
      return;
    }

    if (change == _CodeInputFieldChange.unchanged) {
      _previousValues[index] = controller.text;
      return;
    }

    if (change == _CodeInputFieldChange.fieldChange) {
      _previousValues[index] = controller.text;
      return;
    }

    if (change == _CodeInputFieldChange.fieldBackspace) {
      controller.text = emptyFieldValue;
      _previousValues[index] = controller.text;
      return;
    }

    if (change == _CodeInputFieldChange.emptyFieldBackspace) {
      controller.text = emptyFieldValue;
      _previousValues[index] = emptyFieldValue;

      var backtrackedFirstNotEmptyField =
          _indexOfBacktrackedFirstNotEmptyField(index - 1);

      _controllers[backtrackedFirstNotEmptyField].text = emptyFieldValue;
      _previousValues[backtrackedFirstNotEmptyField] = emptyFieldValue;
      _focusNodes[backtrackedFirstNotEmptyField].requestFocus();

      return;
    }
  }

  int _indexOfBacktrackedFirstNotEmptyField(int searchFromIndex) {
    for (int i = searchFromIndex; i >= 0; i--) {
      if (_controllers[i].text.trim().isNotEmpty) {
        return i;
      }
    }

    return 0;
  }

  TextEditingController _initializeTextEditingControllerForIndex(int index) {
    var codeValue = widget.state.value;

    var valueForIndex =
        codeValue != null && codeValue.length > index ? codeValue[index] : '';
    return TextEditingController(text: valueForIndex);
  }

  FocusNode _createFocusNodeForIndex(int index) {
    return FocusNode(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          _handleKeyEventFocusAtIndex(index, event);
        }
        return KeyEventResult.ignored;
      },
    )..addListener(() {
        if (!_focusNodes[index].hasFocus) {
          return;
        }

        var focussedController = _controllers[index];

        // When the field is empty, add a space to it and make sure the cursor is at the end, this is needed to respond on user's input on backspace
        if (focussedController.text.isEmpty) {
          focussedController.text = emptyFieldValue;
        }
        _setCursorToEnd(focussedController);
        _semanticsAnnounceFieldFocussed(index);
      });
  }

  void _semanticsAnnounceFieldFocussed(int index) {
    var fieldFocussedMessage = _getSemanticsLabelForField(index);
    SemanticsService.announce(fieldFocussedMessage, TextDirection.ltr);
  }

  void _handleKeyEventFocusAtIndex(int index, KeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _focusNextField(index);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _focusPreviousField(index);
    }
  }

  void _setCursorToEnd(TextEditingController controller) {
    controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: controller.text.length,
      ),
    );
  }

  void _focusNextField(int index) {
    if (index < _controllers.length - 1) {
      FocusScope.of(context).nextFocus();
    }
  }

  void _focusPreviousField(int index) {
    if (index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  void _updateValue() {
    String combinedValue = _controllers
        .map((controller) => controller.text)
        .join()
        .padRight(widget.fields, emptyFieldValue);

    widget.state.reset();
    widget.controller?.text = combinedValue.substring(0, widget.fields);
    widget.state.didChange(combinedValue.substring(0, widget.fields));

    var combinedValueHasChanged = combinedValue != _previousCombinedValue;
    if (isComplete() && combinedValueHasChanged) {
      widget.onComplete?.call();
    }

    _previousCombinedValue = combinedValue;
  }

  bool isComplete() {
    return _controllers.every((controller) =>
        controller.text.isNotEmpty && controller.text != emptyFieldValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.state.hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ZbjFormFieldErrorMessage(
              errorText: widget.state.errorText!,
            ),
          ),
        LayoutBuilder(
          builder: (context, constraints) => Row(
            children: List.generate(widget.fields, (index) {
              return _buildInputField(
                  index,
                  (constraints.maxWidth - 8 * (widget.fields - 1)) /
                      widget.fields);
            }),
          ),
        ),
      ],
    );
  }

  String _getSemanticsLabelForField(int index) {
    var indexNumber = index + 1;
    return 'Code $indexNumber van de ${widget.fields}';
  }

  Widget _buildInputField(int index, double maxWidth) {
    var isLastInput = index == widget.fields - 1;
    return Container(
      margin: EdgeInsets.only(right: isLastInput ? 0 : 8),
      height: 48,
      width: min(48, maxWidth),
      child: ZbjFormTextField(
        focusNode: _focusNodes[index],
        controller: _controllers[index],
        inputFormatters: [
          // These formatters are applied in order, so the order is important
          _TrimFormatter(),
          _PasteInterceptorFormatter(onPaste: _handlePaste),
          _PickLastCharacterFormatter(),
          LengthLimitingTextInputFormatter(1),
        ],
        accessibleLabel: _getSemanticsLabelForField(index),
        accessibleValue: _controllers[index].text.trim(),
        autocorrect: false,
        enableSuggestions: false,
        textAlign: TextAlign.center,
        hasError: widget.state.hasError,
        onFieldSubmitted: (val) => widget.onSubmitted?.call(),
        onChanged: (val) {
          if (isComplete()) {
            return;
          }

          if (val.isEmpty || val == emptyFieldValue) {
            return;
          }

          var isLastInput = index == widget.fields - 1;
          if (isLastInput) {
            return;
          }

          _focusNextField(index);
        },
      ),
    );
  }

  void _handlePaste(String pastedText) {
    for (int i = 0; i < pastedText.length && i < _controllers.length; i++) {
      _controllers[i].text = pastedText[i];
    }
    _updateValue();
  }
}

enum _CodeInputFieldChange {
  initial,
  emptyFieldBackspace,
  fieldBackspace,
  fieldChange,
  unchanged,
}

class _PasteInterceptorFormatter extends TextInputFormatter {
  final void Function(String) onPaste;

  _PasteInterceptorFormatter({required this.onPaste});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String pastedText = newValue.text;
    if (pastedText.length > oldValue.text.length + 1) {
      String difference = pastedText;
      if (pastedText.startsWith(oldValue.text)) {
        difference = pastedText.substring(oldValue.text.length);
      }
      onPaste(difference);
    }
    return TextEditingValue(
      text: pastedText,
      selection: TextSelection.collapsed(offset: pastedText.length),
    );
  }
}

class _TrimFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var trimmedText = newValue.text.trim();
    var newSelection = newValue.selection.copyWith(
      baseOffset: trimmedText.length,
      extentOffset: trimmedText.length,
    );
    return TextEditingValue(
      text: trimmedText,
      selection: newSelection,
      composing: newValue.composing,
    );
  }
}

class _PickLastCharacterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length == 2) {
      String lastCharacter = newValue.text.substring(newValue.text.length - 1);
      return TextEditingValue(
        text: lastCharacter,
        selection: TextSelection.collapsed(offset: lastCharacter.length),
      );
    }
    return newValue;
  }
}
