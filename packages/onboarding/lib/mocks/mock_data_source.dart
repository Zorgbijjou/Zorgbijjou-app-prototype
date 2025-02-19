import 'package:mocktail/mocktail.dart';
import 'package:onboarding/data_source/onboarding_data_source.dart';

final mockTermsAndConditionsContent = <String, String>{
  'nl': '''
# ![](images/document-icon.png) Medische gegevens

De informatie die je via de app invult, is medische informatie. <ziekenhuis> is aangesloten bij een samenwerking van 7 ziekenhuizen: Santeon Zorg bij jou. Ook voor thuismonitoring werken wij samen. Voor meer informatie zie ook de website: [Santeon ziekenhuizen](https://santeon.nl/).

# ![](images/document-icon.png) Wie kan mijn gegevens zien

De informatie die je via de app invult, is medische informatie. <ziekenhuis> is aangesloten bij een samenwerking van 7 ziekenhuizen: Santeon Zorg bij jou. Ook voor thuismonitoring werken wij samen. Voor meer informatie zie ook de website: [Santeon ziekenhuizen](https://santeon.nl/).

# ![](images/lock-icon.png) Bescherming van gegevens

Samen met Luscii, BeterDichtbij en Zorg bij jou zijn maatregelen genomen om jouw privacy te bewaken. Je hebt toestemming gegeven voor het delen van medische informatie. Alleen noodzakelijke medische persoonsgegevens worden in de app Thuismeten geplaatst en gedeeld met Luscii, BeterDichtbij en het thuismonitoringscentrum. Wil je geen toestemming meer geven? Neem dan contact op met jouw zorgverlener.

# ![](images/lock-icon.png) Bescherming van gegevens

Samen met Luscii, BeterDichtbij en Zorg bij jou zijn maatregelen genomen om jouw privacy te bewaken. Je hebt toestemming gegeven voor het delen van medische informatie. Alleen noodzakelijke medische persoonsgegevens worden in de app Thuismeten geplaatst en gedeeld met Luscii, BeterDichtbij en het thuismonitoringscentrum. Wil je geen toestemming meer geven? Neem dan contact op met jouw zorgverlener.

''',
};

final mockLoginInformationContent = <String, String>{
  'nl': '''
Je kunt de Zorg bij jou-app alleen gebruiken als je arts je heeft aangemeld bij Zorg bij jou.

Je hebt een e-mail gekregen van Zorg bij jou. Klik op de 'Download de Zorg bij jou app'-knop. Dan ga je direct naar de App Store en kun je de app downloaden. Je hoeft dan geen code in te vullen, dat gebeurt automatisch.

Ga je niet direct naar de app store? Dan ga je na het klikken op de knop naar een webpagina waar je jouw code kunt vinden. Deze code bestaat uit 6 tekens. Vul deze code in op het moment dat de Zorg bij jou-app daar om vraagt.
''',
};

class MockOnboardingDataSource extends Mock implements OnboardingDataSource {
  @override
  Future<String> fetchTermsAndConditionsContent(String locale) {
    return Future.value(mockTermsAndConditionsContent[locale]!);
  }

  @override
  Future<String> fetchLoginInformationContent(String locale) {
    return Future.value(mockLoginInformationContent[locale]!);
  }
}

final mockOnboardingDataSource = MockOnboardingDataSource();
