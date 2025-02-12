import 'package:core/shapes/dotted_border_shape.dart';
import 'package:core/widgets/form_field_error_message.dart';
import 'package:core/widgets/form_input_text_field.dart';
import 'package:core/widgets/outlined_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  testWidgets('ZbjFormInputText renders correctly',
      (WidgetTester tester) async {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();

    await tester.pumpWidget(materialAppWithTokens(
      child: Scaffold(
        body: Form(
          child: ZbjFormInputTextField(
            controller: controller,
            inputFormatters: const [],
            accessibleLabel: 'Test label',
            focusNode: focusNode,
          ),
        ),
      ),
    ));
    focusNode.requestFocus();
    await tester.pump();
    var material = tester.widget<Material>(find.descendant(
        of: find.byType(ZbjFormInputTextField),
        matching: find.byType(Material)));

    // Verify the widget renders correctly
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(OutlinedFocus), findsOneWidget);
    expect(material.shape, isA<DottedBorderShape>());
  });

  testWidgets('ZbjFormInputText suppresses the outline focus',
      (WidgetTester tester) async {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();

    await tester.pumpWidget(materialAppWithTokens(
      child: Scaffold(
        body: Form(
          child: ZbjFormInputTextField(
            suppressOutlineFocus: true,
            controller: controller,
            inputFormatters: const [],
            accessibleLabel: 'Test label',
            focusNode: focusNode,
          ),
        ),
      ),
    ));
    focusNode.requestFocus();
    await tester.pump();
    var material = tester.widget<Material>(find.descendant(
        of: find.byType(ZbjFormInputTextField),
        matching: find.byType(Material)));

    // Verify the widget renders correctly
    expect(material.shape, isNull);
  });

  testWidgets('focuses correctly when FocusNode is provided',
      (WidgetTester tester) async {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();

    await tester.pumpWidget(materialAppWithTokens(
      child: Scaffold(
        body: Form(
          child: ZbjFormInputTextField(
            controller: controller,
            inputFormatters: const [],
            accessibleLabel: 'Test label',
            focusNode: focusNode,
          ),
        ),
      ),
    ));

    // Initially, the TextFormField should not be focused
    expect(focusNode.hasFocus, isFalse);

    // Request focus and pump
    focusNode.requestFocus();
    await tester.pump();

    // Check that the widget is focused now
    expect(focusNode.hasFocus, isTrue);
  });

  testWidgets('triggers onChanged callback when text is entered',
      (WidgetTester tester) async {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();
    String? changedText;

    await tester.pumpWidget(materialAppWithTokens(
      child: Scaffold(
        body: Form(
          child: ZbjFormInputTextField(
            controller: controller,
            inputFormatters: const [],
            accessibleLabel: 'Test label',
            focusNode: focusNode,
            onChanged: (text) {
              changedText = text;
            },
          ),
        ),
      ),
    ));

    // Enter text into the field
    await tester.enterText(find.byType(TextFormField), 'Test input');

    // Verify that the onChanged callback was triggered
    expect(changedText, 'Test input');
  });

  testWidgets('applies input formatters correctly',
      (WidgetTester tester) async {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();
    TextInputFormatter mockInputFormatter =
        FilteringTextInputFormatter.digitsOnly;

    await tester.pumpWidget(materialAppWithTokens(
      child: Scaffold(
        body: Form(
          child: ZbjFormInputTextField(
            controller: controller,
            inputFormatters: [mockInputFormatter],
            accessibleLabel: 'Test label',
            focusNode: focusNode,
          ),
        ),
      ),
    ));

    // Enter text into the field
    await tester.enterText(find.byType(TextFormField), 'Test123');

    // Verify that the text only contains digits
    expect(controller.text, '123');
  });

  testWidgets('pressing enter submits the textfield',
      (WidgetTester tester) async {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();
    bool submitted = false;

    await tester.pumpWidget(materialAppWithTokens(
      child: Scaffold(
        body: Form(
          child: ZbjFormInputTextField(
            controller: controller,
            inputFormatters: const [],
            accessibleLabel: 'Test label',
            focusNode: focusNode,
            onFieldSubmitted: (text) {
              submitted = true;
            },
          ),
        ),
      ),
    ));

    // Enter text into the field
    await tester.enterText(find.byType(TextFormField), '1');

    focusNode.requestFocus();
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);

    expect(submitted, isTrue);
  });

  testWidgets('shows an error when the validator is not happy',
      (WidgetTester tester) async {
    Key formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();
    bool submitted = false;
    bool validated = false;

    await tester.pumpWidget(materialAppWithTokens(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ZbjFormInputTextField(
            controller: controller,
            inputFormatters: const [],
            validator: (val) {
              validated = true;
              return 'Error';
            },
            accessibleLabel: 'Test label',
            focusNode: FocusNode(),
            onFieldSubmitted: (text) {
              submitted = true;
            },
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    var errorTextFinder = find.text('Error');
    var errorWidgetFinder = find.byType(FormFieldErrorMessage);

    expect(errorTextFinder, findsNothing);
    expect(errorWidgetFinder, findsNothing);

    // Enter text into the field and submit
    await tester.enterText(find.byType(TextFormField), '1');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    Form.of(find.byType(ZbjFormInputTextField).evaluate().first).validate();
    await tester.pumpAndSettle();

    expect(validated, isTrue);
    expect(submitted, isTrue);
    expect(errorWidgetFinder, findsOneWidget);
    expect(errorTextFinder, findsOneWidget);
  });

  testWidgets('remove the error when the field is focussed',
      (WidgetTester tester) async {
    Key formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();

    await tester.pumpWidget(materialAppWithTokens(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ZbjFormInputTextField(
            controller: controller,
            inputFormatters: const [],
            validator: (val) {
              return 'Error';
            },
            accessibleLabel: 'Test label',
            focusNode: focusNode,
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    var errorTextFinder = find.text('Error');
    var errorWidgetFinder = find.byType(FormFieldErrorMessage);

    expect(errorTextFinder, findsNothing);
    expect(errorWidgetFinder, findsNothing);

    // Enter text into the field and submit
    await tester.enterText(find.byType(TextFormField), '1');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    Form.of(find.byType(ZbjFormInputTextField).evaluate().first).validate();
    await tester.pumpAndSettle();

    expect(errorWidgetFinder, findsOneWidget);
    expect(errorTextFinder, findsOneWidget);

    focusNode.requestFocus();
    await tester.pumpAndSettle();

    expect(errorTextFinder, findsNothing);
    expect(errorWidgetFinder, findsNothing);
  });
}
