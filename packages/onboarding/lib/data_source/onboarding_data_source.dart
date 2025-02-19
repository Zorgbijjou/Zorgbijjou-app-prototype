abstract class OnboardingDataSource {
  Future<String> fetchTermsAndConditionsContent(String locale);
  Future<String> fetchLoginInformationContent(String locale);
}
