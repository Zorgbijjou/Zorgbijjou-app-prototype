import 'package:flutter_test/flutter_test.dart';
import 'package:onboarding/view_models/validate_information_view_model.dart';
import 'package:onboarding/widgets/validate_information.dart';

import 'login_test.dart';

void main() {
  testWidgets('ValidateInformation displays correct content',
      (WidgetTester tester) async {
    var viewModel = const ValidateInformationViewModel(
      hospitalName: 'Martini Ziekenhuis',
      departmentName: 'Gynaecologie',
      treatmentName: 'Zwangerschapsdiabetes',
      patientName: 'Jeroen Drouwen',
    );

    await tester.pumpWidget(
      materialApp(ValidateInformation(viewModel: viewModel)),
    );

    expect(find.text('Het is gelukt!'), findsOneWidget);
    expect(
        find.text('Je account is met succes gecontroleerd.'), findsOneWidget);
    expect(find.text('We herkennen de volgende gegevens:'), findsOneWidget);
    expect(
        find.text(
            'Je ziekenhuis is het Martini Ziekenhuis en bent onder behandeling bij Gynaecologie'),
        findsOneWidget);
    expect(
        find.text('Je krijgt zorg voor Zwangerschapsdiabetes'), findsOneWidget);
    expect(find.text('Je naam is Jeroen Drouwen'), findsOneWidget);
    expect(find.text('Klopt dit niet?'), findsOneWidget);
  });
}
