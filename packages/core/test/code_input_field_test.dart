import 'package:core/widgets/form_input_code_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  group('CodeInputField component', () {
    testWidgets('CodeInputField initializes with empty values',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 2,
            ),
          ),
        ),
      ));

      // Find the text fields
      var textField1 = find.byType(TextFormField).at(0);
      var textField2 = find.byType(TextFormField).at(1);

      // Ensure the fields are initially empty spaces
      expect(tester.widget<TextFormField>(textField1).controller!.text, '');
      expect(tester.widget<TextFormField>(textField2).controller!.text, '');
    });

    testWidgets('CodeInputField updates values on input',
        (WidgetTester tester) async {
      String? formFieldValue;

      var controller = TextEditingController();

      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              controller: controller,
              fields: 2,
              onSaved: (val) => formFieldValue = val,
            ),
          ),
        ),
      ));

      // Enter 'A' in the first text field
      await tester.enterText(find.byType(TextFormField).at(0), 'A');
      await tester.pump();

      // Enter 'B' in the second text field
      await tester.enterText(find.byType(TextFormField).at(1), 'B');
      await tester.pump();

      // Submit the form and check that the value is saved
      var form = find.byType(Form);
      var formState = tester.state<FormState>(form);
      formState.save();

      expect(formFieldValue, equals('AB'));
      expect(controller.text, equals('AB'));
    });

    testWidgets('CodeInputField coverts input to uppercase',
        (WidgetTester tester) async {
      String? formFieldValue;

      var controller = TextEditingController();

      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              controller: controller,
              fields: 3,
              onSaved: (val) => formFieldValue = val,
            ),
          ),
        ),
      ));

      // Enter 'a' in the first text field
      await tester.enterText(find.byType(TextFormField).at(0), 'a');
      await tester.pump();

      // Enter 'B' in the second text field
      await tester.enterText(find.byType(TextFormField).at(1), 'b');
      await tester.pump();

      // Enter 'c' in the third text field
      await tester.enterText(find.byType(TextFormField).at(2), 'c');
      await tester.pump();

      // Submit the form and check that the value is saved
      var form = find.byType(Form);
      var formState = tester.state<FormState>(form);
      formState.save();

      expect(formFieldValue, equals('ABC'));
      expect(controller.text, equals('ABC'));
    });

    testWidgets('CodeInputField does not show error text',
        (WidgetTester tester) async {
      // Build the widget with a form and validation
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 2,
              validator: (val) {
                if (val == null || val.length != 2) {
                  return 'Invalid';
                }
                return null;
              },
            ),
          ),
        ),
      ));

      // Trigger validation without input
      var form = find.byType(Form);
      var formState = tester.state<FormState>(form);
      formState.validate();
      await tester.pump();

      // Ensure there is no error text in either of the TextFormFields
      var textField1 = find.byType(TextFormField).at(0);
      var textField2 = find.byType(TextFormField).at(1);

      expect(find.descendant(of: textField1, matching: find.text('Invalid')),
          findsNothing);
      expect(find.descendant(of: textField2, matching: find.text('Invalid')),
          findsNothing);
    });

    testWidgets('CodeInputField does not show error text after focus change',
        (WidgetTester tester) async {
      // Build the widget with a form and validation
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 2,
              validator: (val) {
                if (val != 'AB') {
                  return 'Invalid';
                }
                return null;
              },
            ),
          ),
        ),
      ));

      // Trigger validation with input
      var form = find.byType(Form);
      var formState = tester.state<FormState>(form);
      formState.validate();
      await tester.pump();

      expect(find.text('Invalid'), findsOneWidget);

      // Ensure there is no error text when selecting field
      await tester.enterText(find.byType(TextFormField).at(0), 'A');
      await tester.pump();

      expect(find.text('Invalid'), findsNothing);
    });

    // test pasting code 12345 inside the first text field
    testWidgets('CodeInputField allows pasting code into fields',
        (WidgetTester tester) async {
      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 6,
            ),
          ),
        ),
      ));

      // Simulate pasting '12345' into the first text field
      await tester.enterText(find.byType(TextFormField).at(0), '12345');
      await tester.pump();

      // Check that the first text field contains '
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    // should focus next field when keyboard right arrow key is pressed
    testWidgets('CodeInputField focuses next field on right arrow key press',
        (WidgetTester tester) async {
      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 2,
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(TextFormField).at(0));
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();

      EditableText secondField =
          tester.widget<EditableText>(find.byType(EditableText).at(1));

      expect(tester.binding.focusManager.primaryFocus,
          equals(secondField.focusNode));
    });

    // should focus previous field when keyboard left arrow key is pressed
    testWidgets('CodeInputField focuses previous field on left arrow key press',
        (WidgetTester tester) async {
      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 2,
              controller: TextEditingController(text: 'A'),
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(TextFormField).at(1));
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();

      EditableText firstField =
          tester.widget<EditableText>(find.byType(EditableText).at(0));

      expect(tester.binding.focusManager.primaryFocus,
          equals(firstField.focusNode));
    });

    testWidgets(
        'CodeInputField focus and clear previous field on backspace press when current field is empty',
        (WidgetTester tester) async {
      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 4,
              controller: TextEditingController(text: 'ABC'),
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(TextFormField).at(3));
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
      await tester.pump();

      // Check that the last field is empty
      expect(find.text('C'), findsNothing);

      EditableText firstField =
          tester.widget<EditableText>(find.byType(EditableText).at(2));

      expect(tester.binding.focusManager.primaryFocus,
          equals(firstField.focusNode));
    });

    testWidgets(
        'CodeInputField clear current field on backspace press when current field is not empty',
        (WidgetTester tester) async {
      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 4,
              controller: TextEditingController(text: 'ABC'),
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(TextFormField).at(2));
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
      await tester.pump();

      // Check that the last field is empty
      expect(find.text('C'), findsNothing);

      // Keep focus in the same field
      EditableText firstField =
          tester.widget<EditableText>(find.byType(EditableText).at(2));

      expect(tester.binding.focusManager.primaryFocus,
          equals(firstField.focusNode));
    });

    testWidgets(
        'CodeInputField should call onComplete when last field is filled',
        (WidgetTester tester) async {
      // Create a mock function for onComplete
      var onComplete = MockFunction();

      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 2,
              controller: TextEditingController(),
              onComplete: onComplete.call,
            ),
          ),
        ),
      ));

      await tester.enterText(find.byType(EditableText).at(0), '1');
      await tester.pump();

      await tester.enterText(find.byType(EditableText).at(1), '1');
      await tester.pump();

      // Verify that onComplete is called
      verify(onComplete.call).called(1);
    });

    // should call onSubmitted when a field is filled and user is done
    testWidgets(
        'CodeInputField should call onSubmitted when a field is filled and user is done',
        (WidgetTester tester) async {
      // Create a mock function for onSubmitted
      var onSubmitted = MockFunction();

      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 2,
              controller: TextEditingController(),
              onSubmitted: onSubmitted.call,
            ),
          ),
        ),
      ));

      await tester.enterText(find.byType(EditableText).at(0), '1');
      await tester.pump();

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      verify(onSubmitted.call).called(1);
    });

    testWidgets(
        'CodeInputField get square input fields when there is enough space',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(materialAppWithTokens(
        child: Center(
          child: SizedBox(
            width: 500,
            height: 50,
            child: ZbjFormInputCodeField(
              fields: 2,
            ),
          ),
        ),
      ));

      // Find the text fields
      var textField1 = find.byType(TextFormField).at(0);
      var textField2 = find.byType(TextFormField).at(1);

      // Ensure the fields are initially empty
      expect(tester.element(textField1).size, const Size(48.0, 48.0));
      expect(tester.element(textField2).size, const Size(48.0, 48.0));
    });

    testWidgets(
        'CodeInputField get rectangle input fields when there is not enough space',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(materialAppWithTokens(
        child: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: ZbjFormInputCodeField(
              fields: 2,
            ),
          ),
        ),
      ));

      // Find the text fields
      var textField1 = find.byType(TextFormField).at(0);
      var textField2 = find.byType(TextFormField).at(1);

      // Ensure the fields are initially empty
      expect(tester.element(textField1).size, const Size(21.0, 48.0));
      expect(tester.element(textField2).size, const Size(21.0, 48.0));
    });

    // Add test for backtracking logic
    testWidgets(
        'CodeInputField should backtrack focus when backspace is empty field',
        (WidgetTester tester) async {
      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 4,
              controller: TextEditingController(text: ''),
            ),
          ),
        ),
      ));

      await tester.enterText(find.byType(EditableText).at(0), 'A');
      await tester.pump();

      await tester.enterText(find.byType(EditableText).at(3), 'D');
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
      await tester.pump();

      // Keep focus in the same field
      EditableText fourthField =
          tester.widget<EditableText>(find.byType(EditableText).at(3));

      expect(tester.binding.focusManager.primaryFocus,
          equals(fourthField.focusNode));

      // Press backspace again
      await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
      await tester.pump();

      // first field has focus
      EditableText firstField =
          tester.widget<EditableText>(find.byType(EditableText).at(0));

      expect(tester.binding.focusManager.primaryFocus,
          equals(firstField.focusNode));
    });

    testWidgets('CodeInputField inputs are accessible for screen readers',
        (WidgetTester tester) async {
      // Build the widget with a form
      await tester.pumpWidget(materialAppWithTokens(
        child: Scaffold(
          body: Form(
            child: ZbjFormInputCodeField(
              fields: 4,
            ),
          ),
        ),
      ));

      // Find the text fields
      var textField1 = find.byType(TextFormField).at(0);
      var textField2 = find.byType(TextFormField).at(1);
      var textField3 = find.byType(TextFormField).at(2);
      var textField4 = find.byType(TextFormField).at(3);

      // Ensure the fields have the correct semantics
      expect(
        tester.getSemantics(textField1),
        matchesSemantics(
          label: 'Code 1 van de 4',
          value: '',
          isTextField: true,
          hasEnabledState: true,
          isEnabled: true,
        ),
      );

      expect(
        tester.getSemantics(textField2),
        matchesSemantics(
          label: 'Code 2 van de 4',
          value: '',
          isTextField: true,
          hasEnabledState: true,
          isEnabled: true,
        ),
      );
      expect(
        tester.getSemantics(textField3),
        matchesSemantics(
          label: 'Code 3 van de 4',
          value: '',
          isTextField: true,
          hasEnabledState: true,
          isEnabled: true,
        ),
      );
      expect(
        tester.getSemantics(textField4),
        matchesSemantics(
          label: 'Code 4 van de 4',
          value: '',
          isTextField: true,
          hasEnabledState: true,
          isEnabled: true,
        ),
      );
    });
  });
}
