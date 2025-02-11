import 'package:flutter/services.dart';

import 'onboarding_data_source.dart';

class OnboardingDataSourceImpl implements OnboardingDataSource {
  final AssetBundle bundle;

  OnboardingDataSourceImpl({
    required this.bundle,
  });

  @override
  Future<String> fetchTermsAndConditionsContent(String locale) async {
    var contentPath = 'assets/onboarding/terms-and-conditions-$locale.md';

    var content = await bundle.loadString(contentPath, cache: false);
    return content;
  }

  @override
  Future<String> fetchLoginInformationContent(String locale) async {
    var contentPath = 'assets/onboarding/login-information-$locale.md';

    var content = await bundle.loadString(contentPath, cache: false);
    return content;
  }
}
