import 'package:core/widgets/form_field_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  testWidgets('FormFieldErrorMessage displays error text',
      (WidgetTester tester) async {
    const errorText = 'This is an error message';

    await tester.pumpWidget(
      materialAppWithTokens(
        child: const ZbjFormFieldErrorMessage(
          errorText: errorText,
        ),
      ),
    );

    expect(find.text(errorText), findsOneWidget);
    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
  });

  testWidgets('FormFieldErrorMessage has correct semantics',
      (WidgetTester tester) async {
    const errorText = 'This is an error message';

    await tester.pumpWidget(materialAppWithTokens(
      child: const ZbjFormFieldErrorMessage(
        errorText: errorText,
      ),
    ));

    var errorMessage = find.text(errorText);

    expect(errorMessage, findsOneWidget);

    expect(
      tester.getSemantics(errorMessage),
      matchesSemantics(
        label: 'This is an error message',
      ),
    );
  });
}
