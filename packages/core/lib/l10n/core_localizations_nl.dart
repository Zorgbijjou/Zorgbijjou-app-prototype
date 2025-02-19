// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'core_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get customerService => 'Klantenservice';

  @override
  String lastModified(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('d MMM y', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Laatst bijgewerkt: $dateString';
  }

  @override
  String question(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vragen',
      one: '1 vraag',
      zero: 'geen vragen',
    );
    return '$_temp0';
  }

  @override
  String get questionsBySubject => 'Vragen per onderwerp';

  @override
  String get frequentlyAskedQuestions => 'Veelgestelde vragen';

  @override
  String get contactFooterHeader => 'Heb je een andere vraag?';

  @override
  String get contactFooterInformation =>
      'We staan voor je klaar. We zijn er op werkdagen van 08:00 tot 17:00.';

  @override
  String get contactFooterCallUs => 'Bel ons';

  @override
  String get contactFooterConversation => 'Start een gesprek';

  @override
  String get faqMoreQuestions => 'Meer vragen';

  @override
  String get contentNotAvailable =>
      'De tekst is helaas op dit moment niet beschikbaar';

  @override
  String get noLusciiEmail => 'Ik heb geen e-mail van Luscii gekregen, wat nu?';

  @override
  String get noLusciiEmailIntroduction =>
      'Heb je geen e-mail ontvangen? Dat is vervelend. We lossen dit stap voor stap met je op.';

  @override
  String get isHomeMeasurementFree => 'Is thuismeten van Zorg bij jou gratis?';

  @override
  String get canIStopHomeMeasurement => 'Kan ik stoppen met thuismeten?';

  @override
  String get howDoesHomeMeasurementWork => 'Hoe werkt thuismeten?';

  @override
  String get beginHomeMeasurement =>
      'Wat moet ik doen om te beginnen met thuismeten?';

  @override
  String get whenDoesTheNurseRespond =>
      'Wanneer reageert de verpleegkundige op mijn bericht?';

  @override
  String get howIsMyPrivacy => 'Hoe zit het met mijn privacy?';

  @override
  String get whyShouldIKeepMeasuring =>
      'Waarom moet ik blijven meten, zelfs als ik me goed voel?';

  @override
  String get howDoesHomeMeasurementAppWork => 'Hoe werkt de thuismeten app?';

  @override
  String get homeMeasurementApp => 'Thuismeten app';

  @override
  String get howDoIConductAMeasurement =>
      'Hoe doe ik een meting in de Thuismeten app?';

  @override
  String get iDidNotReceiveAnInvitation =>
      'Ik heb geen uitnodiging voor de Thuismeten app gekregen, wat nu?';

  @override
  String get howDoIStopNotifications =>
      'Ik ga op vakantie, hoe zorg ik dat ik tijdelijk geen meldingen krijg?';

  @override
  String get digitalAccessibilityHomeMeasurementsApp =>
      'Digitale toegankelijkheid en de Thuismeten app';

  @override
  String get digitalAccessibilityZorgBijJouApp =>
      'Digitale toegankelijkheid en de Zorg bij jou app';

  @override
  String get doINeedTheHomeMeasurementsApp =>
      'Heb ik de Thuismeten app echt nodig?';

  @override
  String get doINeedTheZorgBijJouApp =>
      'Heb ik de Zorg bij jou app echt nodig?';

  @override
  String get zorgBijJouApp => 'Zorg bij jou app';

  @override
  String get myHeartRateMonitor => 'Mijn hartslagmeter';

  @override
  String get heartFailure => 'Hartfalen';

  @override
  String get homeMeasurementWithHeartFailure => 'Thuismeten met hartfalen';

  @override
  String get zorgBijJou => 'Zorg bij jou';

  @override
  String get welcome => 'Welkom terug';

  @override
  String get localAuthChallengeReason => 'Ontgrendel de Zorgbijjou app';

  @override
  String get localAuthCancelButton => 'Terug';

  @override
  String get localAuthChallengeAgain => 'Ontgrendel de Zorgbijjou app';

  @override
  String get localAuthToOnboarding => 'Terug naar inloggen';

  @override
  String get onboardingConditionsHeader => 'We hebben je toestemming nodig';

  @override
  String get onboardingConditionsExplanation =>
      'Om Zorg bij jou te kunnen gebruiken, moet je akkoord gaan met:';

  @override
  String get onboardingConditionsItem1 =>
      'Wij verzamelen medische gegevens via vragen of metingen die je doet. Bijvoorbeeld je gewicht of hartslag.';

  @override
  String get onboardingConditionsItem2 =>
      'Je gegevens zijn te zien voor de verpleegkundigen en je behandelaar.';

  @override
  String get onboardingConditionsItem3 =>
      'Je gegevens worden veilig opgeslagen.';

  @override
  String get onboardingConditionsReadAllButton => 'Lees alle voorwaarden';

  @override
  String get onboardingConditionsAgreeButton => 'Ik ga akkoord';

  @override
  String get onboardingValidateInformationValidateButton => 'Gegevens kloppen';

  @override
  String get termsAndConditionsHeader => 'Complete voorwaarden';

  @override
  String get onboardingLoginHeader => 'We controleren je account';

  @override
  String get onboardingLoginParagraph =>
      'Om de app te gebruiken, vul hier de code in die je hebt ontvangen en je geboortedatum. Zo zorgen we ervoor dat jouw account klopt en veilig is.';

  @override
  String get loginCodeHeader => 'Vul de code in';

  @override
  String get birthDateAccessibleLabel => 'Geboortedatum';

  @override
  String get birthDateHeader => 'Vul je geboortedatum in (dd-mm-jjjj)';

  @override
  String get birthDateExample => 'bijv. 09-12-1981';

  @override
  String get onboardingShowLoginInformationButton =>
      'Waar kan ik de code vinden?';

  @override
  String get loginInformationHeader => 'Waar kan ik de code vinden?';

  @override
  String get birthDateIncomplete => 'Vul alsjeblieft je geboortedatum in.';

  @override
  String get loginCodeIncomplete => 'Vul alsjeblieft je code in.';

  @override
  String get loginCodeWrong =>
      'Sorry, we herkennen deze code niet. Controleer of je het goed hebt ingevuld.';

  @override
  String get loginAuthenticationErrorTitle => 'Dit account wordt niet herkend';

  @override
  String get loginAuthenticationErrorMessage =>
      'Controleer of je de code en je geboortedatum goed hebt ingevuld en probeer het opnieuw. Werkt het nog steeds niet? Bel dan het Medisch Service Centrum op +31 6 0192837.';

  @override
  String get unexpectedErrorTitle => 'Onverwachte fout opgetreden';

  @override
  String get unexpectedErrorMessage =>
      'Er is een onverwachte fout opgetreden. Controleer je internet verbinding en probeer het opnieuw.';

  @override
  String get onboardingGettingStartedHeader =>
      'Download de Thuismeten app om te beginnen';

  @override
  String get onboardingGettingStartedParagraph1 =>
      'De laatste stap is zorgen dat je de Thuismeten-app geïnstalleerd hebt staan op je telefoon.';

  @override
  String get onboardingGettingStartedParagraph2 =>
      'Heb je de Thuismeten-app al geïnstalleerd? Ga dan direct aan de slag met meten in de Zorg bij jou-app.';

  @override
  String get onboardingGettingStartedParagraph3 =>
      'Nog niet de Thuismeten-app geïnstalleerd? Check je e-mail (ook ongewenste e-mail) voor de uitnodiging van Luscii, de ontwikkelaar van de Thuismeten-app, en volg de instructies.';

  @override
  String get onboardingGettingStartedButton => 'Begrepen';

  @override
  String get onboardingMultipleAppsIntroductionHeader =>
      'Welkom! Samen houden we jouw gezondheid in de gaten';

  @override
  String get onboardingMultipleAppsIntroductionParagraph =>
      'Voor je behandeling heb je twee apps nodig. We leggen je graag uit wat je met deze apps kan.';

  @override
  String get onboardingMultipleAppsIntroductionImage =>
      'Afbeelding van twee app-iconen: de eerste met de naam \'Zorg bij jou\' en de tweede met de naam \'Thuismeten\'.';

  @override
  String get onboardingMultipleAppsZorgBijJouHeader => 'Zorg bij jou';

  @override
  String get onboardingMultipleAppsZorgBijJouParagraph =>
      'De Zorg bij jou app (deze app) gebruik je voor:';

  @override
  String get onboardingMultipleAppsZorgBijJouItem1Title =>
      'Contact met verpleegkundigen.';

  @override
  String get onboardingMultipleAppsZorgBijJouItem1Description =>
      'Heb je zorgen over een meting of andere gezondheidsvragen? Je kunt contact opnemen met de verpleegkundige via deze app. Ook nemen zij contact met jou op bij vragen.';

  @override
  String get onboardingMultipleAppsZorgBijJouItem2Title => 'Hulp bij vragen.';

  @override
  String get onboardingMultipleAppsZorgBijJouItem2Description =>
      'Vind snel antwoorden op veelgestelde vragen over bijvoorbeeld het thuismeten en meer.';

  @override
  String get onboardingMultipleAppsHomeMeasurementHeader => 'Thuismeten';

  @override
  String get onboardingMultipleAppsHomeMeasurementParagraph =>
      'De Thuismeten app helpt je bij het in de gaten houden van je gezondheid:';

  @override
  String get onboardingMultipleAppsHomeMeasurementItem1Title =>
      'Zelf metingen doorgeven.';

  @override
  String get onboardingMultipleAppsHomeMeasurementItem1Description =>
      'Geef je gemeten waardes door, zoals je bloedglucose, om je diabetes in de gaten te houden.';

  @override
  String get onboardingMultipleAppsHomeMeasurementItem2Title => 'Krijg advies.';

  @override
  String get onboardingMultipleAppsHomeMeasurementItem2Description =>
      'Met jouw antwoorden en metingen geeft de app je meteen feedback en advies om je diabetes onder controle te houden.';

  @override
  String get backButton => 'Terug';

  @override
  String get nextButtonAccessibilityLabel => 'Ga verder';

  @override
  String statusBarAccessibilityLabel(int currentPage, int totalPages) {
    return 'Stap $currentPage van $totalPages, actief';
  }

  @override
  String get bottomNavigationService => 'Service';

  @override
  String get conversationTitle => 'Gesprek';

  @override
  String get noConversations => 'Geen gesprekken';

  @override
  String get conversationNewMessage => 'Nieuw';

  @override
  String get conversationYesterday => 'Gisteren';

  @override
  String conversationTime(DateTime datetime) {
    final intl.DateFormat datetimeDateFormat =
        intl.DateFormat('H:mm', localeName);
    final String datetimeString = datetimeDateFormat.format(datetime);

    return '$datetimeString';
  }

  @override
  String conversationDateTime(DateTime datetime) {
    final intl.DateFormat datetimeDateFormat =
        intl.DateFormat('d MMM y, H:mm', localeName);
    final String datetimeString = datetimeDateFormat.format(datetime);

    return '$datetimeString';
  }

  @override
  String conversationDate(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('d MMM y', localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String conversationAvatarSemanticLabel(String name) {
    return 'Avatar $name';
  }

  @override
  String get conversationFromSystemSemanticLabel => 'van de App';

  @override
  String conversationMessageSemanticLabel(String user, String message,
      String conversation, DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('dMMMMy', localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    return 'Bericht van $user. $message. Ontvangen in $conversation op $dateString $timeString.';
  }

  @override
  String conversationSemanticLabel(String title, String message, DateTime date,
      DateTime time, int unreadMessages) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('dMMMMy', localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    String _temp0 = intl.Intl.pluralLogic(
      unreadMessages,
      locale: localeName,
      other: ' $unreadMessages ongelezen berichten.',
      one: ' 1 ongelezen bericht.',
      zero: '',
    );
    return 'Bericht: $title. $message. $dateString $timeString.$_temp0';
  }

  @override
  String conversationNoMessageSemanticLabel(String title, int unreadMessages) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadMessages,
      locale: localeName,
      other: ' $unreadMessages ongelezen berichten.',
      one: ' 1 ongelezen bericht.',
      zero: '',
    );
    return 'Bericht: $title.$_temp0';
  }

  @override
  String get conversationSendMessageSemanticLabel => 'Bericht';

  @override
  String get validateInformationSuccessTitle => 'Het is gelukt!';

  @override
  String get validateInformationSuccessContent =>
      'Je account is met succes gecontroleerd.';

  @override
  String get validateInformationRecognizedData =>
      'We herkennen de volgende gegevens:';

  @override
  String validateInformationHospitalDepartment(
      String hospitalName, String departmentName) {
    return 'Je ziekenhuis is het $hospitalName en bent onder behandeling bij $departmentName';
  }

  @override
  String validateInformationTreatment(String treatmentName) {
    return 'Je krijgt zorg voor $treatmentName';
  }

  @override
  String validateInformationPatientName(String patientName) {
    return 'Je naam is $patientName';
  }

  @override
  String get validateInformationIncorrectButton => 'Klopt dit niet?';

  @override
  String get validateInformationNextButton => 'Gegevens kloppen';
}
