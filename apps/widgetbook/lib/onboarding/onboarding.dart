import 'package:core/core.dart';
import 'package:core/data_source/locale_data_source_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding/onboarding.dart';
import 'package:onboarding/view_models/onboarding_view_model.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Page',
  type: Onboarding,
  path: 'Onboarding',
)
Widget buildOnboardingPageUseCase(BuildContext context) {
  var localeDataSource = LocaleDataSourceImpl(bundle: rootBundle);

  var translationRepository =
      TranslationRepositoryImpl(localeDataSource: localeDataSource);

  var locale = Localizations.localeOf(context);

  var homeViewModel = OnboardingViewModel(
    pageController: PageController(),
    termsAndConditionsContent:
        mockTermsAndConditionsContent[locale.languageCode],
    components: [
      TermsAndConditionsSummary(
        onTermsAndConditionsClicked: (_) {},
        onContinue: () {},
      ),
    ],
  );

  return FutureBuilder(
    future: localeDataSource.initializeLocales(['nl', 'en']),
    builder: (context, _) => Onboarding(
      viewModel: homeViewModel,
      translationRepository: translationRepository,
    ),
  );
}
