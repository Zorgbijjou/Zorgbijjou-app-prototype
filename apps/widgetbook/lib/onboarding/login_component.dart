import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding/view_models/login_view_model.dart';
import 'package:onboarding/widgets/login.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: Login,
  path: 'Onboarding',
)
Widget buildOnboardingPageUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);

  var viewModel = LoginViewModel(
    error: context.knobs.listOrNull(
      label: 'Error',
      options: LoginError.values,
      labelBuilder: (value) => value?.name.toString() ?? 'null',
    ),
  );

  return FutureBuilder(
    future: localeDataSource.initializeLocales(['nl', 'en']),
    builder: (context, _) => Container(
      color: Colors.white,
      child: SafeArea(
        child: Login(
          formKey: GlobalKey<FormState>(),
          loginCodeController: TextEditingController(),
          birthDateController: TextEditingController(),
          onSubmitLogin: () {},
          onShowLoginInformationClicked: (BuildContext context) {},
          viewModel: viewModel,
        ),
      ),
    ),
  );
}
