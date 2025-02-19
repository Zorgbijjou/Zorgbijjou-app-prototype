import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onboarding/data_source/onboarding_data_source_impl.dart';

class MockBundle extends Mock implements AssetBundle {}

void main() {
  group('OnboardingDataSourceImpl', () {
    test(
        'should read terms and conditions content markdowns for different locales',
        () async {
      var mockBundle = MockBundle();

      when(() => mockBundle.loadString(
              'assets/onboarding/terms-and-conditions-nl.md',
              cache: false))
          .thenAnswer((_) => Future.value('# Pretty markdown NL'));

      when(() => mockBundle.loadString(
              'assets/onboarding/terms-and-conditions-en.md',
              cache: false))
          .thenAnswer((_) => Future.value('# Pretty markdown EN'));

      var dataSource = OnboardingDataSourceImpl(bundle: mockBundle);
      var resultNl = await dataSource.fetchTermsAndConditionsContent('nl');
      expect(resultNl, '# Pretty markdown NL');

      verify(() => mockBundle.loadString(
          'assets/onboarding/terms-and-conditions-nl.md',
          cache: false)).called(1);

      var resultEn = await dataSource.fetchTermsAndConditionsContent('en');
      expect(resultEn, '# Pretty markdown EN');

      verify(() => mockBundle.loadString(
          'assets/onboarding/terms-and-conditions-en.md',
          cache: false)).called(1);
    });

    test('should read information content markdowns for different locales',
        () async {
      var mockBundle = MockBundle();

      when(() => mockBundle.loadString(
              'assets/onboarding/login-information-nl.md',
              cache: false))
          .thenAnswer((_) => Future.value('# Pretty markdown NL'));

      when(() => mockBundle.loadString(
              'assets/onboarding/login-information-en.md',
              cache: false))
          .thenAnswer((_) => Future.value('# Pretty markdown EN'));

      var dataSource = OnboardingDataSourceImpl(bundle: mockBundle);
      var resultNl = await dataSource.fetchLoginInformationContent('nl');
      expect(resultNl, '# Pretty markdown NL');

      verify(() => mockBundle.loadString(
          'assets/onboarding/login-information-nl.md',
          cache: false)).called(1);

      var resultEn = await dataSource.fetchLoginInformationContent('en');
      expect(resultEn, '# Pretty markdown EN');

      verify(() => mockBundle.loadString(
          'assets/onboarding/login-information-en.md',
          cache: false)).called(1);
    });
  });
}
