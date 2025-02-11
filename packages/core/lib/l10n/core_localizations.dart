import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'core_localizations_en.dart';
import 'core_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/core_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl')
  ];

  /// Customer service
  ///
  /// In nl, this message translates to:
  /// **'Klantenservice'**
  String get customerService;

  /// Last modified
  ///
  /// In nl, this message translates to:
  /// **'Laatst bijgewerkt: {date}'**
  String lastModified(DateTime date);

  /// [count|'no'] question(s)
  ///
  /// In nl, this message translates to:
  /// **'{count, plural, =0{geen vragen} =1{1 vraag} other{{count} vragen}}'**
  String question(num count);

  /// Questions  by subject
  ///
  /// In nl, this message translates to:
  /// **'Vragen per onderwerp'**
  String get questionsBySubject;

  /// Frequently asked questions
  ///
  /// In nl, this message translates to:
  /// **'Veelgestelde vragen'**
  String get frequentlyAskedQuestions;

  /// Contact Footer header
  ///
  /// In nl, this message translates to:
  /// **'Heb je een andere vraag?'**
  String get contactFooterHeader;

  /// Contact Footer information
  ///
  /// In nl, this message translates to:
  /// **'We staan voor je klaar. We zijn er op werkdagen van 08:00 tot 17:00.'**
  String get contactFooterInformation;

  /// Contact Footer call us
  ///
  /// In nl, this message translates to:
  /// **'Bel ons'**
  String get contactFooterCallUs;

  /// Contact Footer start a conversation
  ///
  /// In nl, this message translates to:
  /// **'Start een gesprek'**
  String get contactFooterConversation;

  /// FAQ page more question
  ///
  /// In nl, this message translates to:
  /// **'Meer vragen'**
  String get faqMoreQuestions;

  /// Content not available
  ///
  /// In nl, this message translates to:
  /// **'De tekst is helaas op dit moment niet beschikbaar'**
  String get contentNotAvailable;

  /// I did not receive an e-mail from Luscii, now what?
  ///
  /// In nl, this message translates to:
  /// **'Ik heb geen e-mail van Luscii gekregen, wat nu?'**
  String get noLusciiEmail;

  /// You haven't received an e-mail? We're sorry. We will fix this step by step together with you
  ///
  /// In nl, this message translates to:
  /// **'Heb je geen e-mail ontvangen? Dat is vervelend. We lossen dit stap voor stap met je op.'**
  String get noLusciiEmailIntroduction;

  /// Is home measurement by Zorg bij jou free?
  ///
  /// In nl, this message translates to:
  /// **'Is thuismeten van Zorg bij jou gratis?'**
  String get isHomeMeasurementFree;

  /// Can I stop home measurement?
  ///
  /// In nl, this message translates to:
  /// **'Kan ik stoppen met thuismeten?'**
  String get canIStopHomeMeasurement;

  /// How does home measurement work
  ///
  /// In nl, this message translates to:
  /// **'Hoe werkt thuismeten?'**
  String get howDoesHomeMeasurementWork;

  /// What do I need to do to start home monitoring?
  ///
  /// In nl, this message translates to:
  /// **'Wat moet ik doen om te beginnen met thuismeten?'**
  String get beginHomeMeasurement;

  /// When will the nurse respond to my message?
  ///
  /// In nl, this message translates to:
  /// **'Wanneer reageert de verpleegkundige op mijn bericht?'**
  String get whenDoesTheNurseRespond;

  /// What about my privacy?
  ///
  /// In nl, this message translates to:
  /// **'Hoe zit het met mijn privacy?'**
  String get howIsMyPrivacy;

  /// Why do I need to continue measuring, even if I feel fine?
  ///
  /// In nl, this message translates to:
  /// **'Waarom moet ik blijven meten, zelfs als ik me goed voel?'**
  String get whyShouldIKeepMeasuring;

  /// How does home measurement app work
  ///
  /// In nl, this message translates to:
  /// **'Hoe werkt de thuismeten app?'**
  String get howDoesHomeMeasurementAppWork;

  /// Home measurement app
  ///
  /// In nl, this message translates to:
  /// **'Thuismeten app'**
  String get homeMeasurementApp;

  /// How do I perform a measurement in the Home Monitoring app?
  ///
  /// In nl, this message translates to:
  /// **'Hoe doe ik een meting in de Thuismeten app?'**
  String get howDoIConductAMeasurement;

  /// I haven’t received an invitation for the Home Monitoring app. What should I do?
  ///
  /// In nl, this message translates to:
  /// **'Ik heb geen uitnodiging voor de Thuismeten app gekregen, wat nu?'**
  String get iDidNotReceiveAnInvitation;

  /// How can I ensure I don’t receive notifications during my vacation?
  ///
  /// In nl, this message translates to:
  /// **'Ik ga op vakantie, hoe zorg ik dat ik tijdelijk geen meldingen krijg?'**
  String get howDoIStopNotifications;

  /// Digital accessibility of the Home Monitoring app
  ///
  /// In nl, this message translates to:
  /// **'Digitale toegankelijkheid en de Thuismeten app'**
  String get digitalAccessibilityHomeMeasurementsApp;

  /// Digital accessibility of the Zorg bij jou app
  ///
  /// In nl, this message translates to:
  /// **'Digitale toegankelijkheid en de Zorg bij jou app'**
  String get digitalAccessibilityZorgBijJouApp;

  /// Do I really need the Home Monitoring app?
  ///
  /// In nl, this message translates to:
  /// **'Heb ik de Thuismeten app echt nodig?'**
  String get doINeedTheHomeMeasurementsApp;

  /// Do I really need the Zorg bij jou app?
  ///
  /// In nl, this message translates to:
  /// **'Heb ik de Zorg bij jou app echt nodig?'**
  String get doINeedTheZorgBijJouApp;

  /// Zorg bij jou app
  ///
  /// In nl, this message translates to:
  /// **'Zorg bij jou app'**
  String get zorgBijJouApp;

  /// My heart rate monitor
  ///
  /// In nl, this message translates to:
  /// **'Mijn hartslagmeter'**
  String get myHeartRateMonitor;

  /// Heart failure
  ///
  /// In nl, this message translates to:
  /// **'Hartfalen'**
  String get heartFailure;

  /// Home measurement with heart failure
  ///
  /// In nl, this message translates to:
  /// **'Thuismeten met hartfalen'**
  String get homeMeasurementWithHeartFailure;

  /// Zorg bij jou
  ///
  /// In nl, this message translates to:
  /// **'Zorg bij jou'**
  String get zorgBijJou;

  /// Welkom back
  ///
  /// In nl, this message translates to:
  /// **'Welkom terug'**
  String get welcome;

  /// Message to see when the user gets the local authentication challenge
  ///
  /// In nl, this message translates to:
  /// **'Ontgrendel de Zorgbijjou app'**
  String get localAuthChallengeReason;

  /// Cancel button when the user gets the local authentication challenge
  ///
  /// In nl, this message translates to:
  /// **'Terug'**
  String get localAuthCancelButton;

  /// Local auth button to give the local auth challenge
  ///
  /// In nl, this message translates to:
  /// **'Ontgrendel de Zorgbijjou app'**
  String get localAuthChallengeAgain;

  /// Local auth button to go back to onboarding
  ///
  /// In nl, this message translates to:
  /// **'Terug naar inloggen'**
  String get localAuthToOnboarding;

  /// Conditions Summary header for the Onboarding
  ///
  /// In nl, this message translates to:
  /// **'We hebben je toestemming nodig'**
  String get onboardingConditionsHeader;

  /// Conditions Summary explanation for the Onboarding
  ///
  /// In nl, this message translates to:
  /// **'Om Zorg bij jou te kunnen gebruiken, moet je akkoord gaan met:'**
  String get onboardingConditionsExplanation;

  /// Conditions Summary bullet item 1
  ///
  /// In nl, this message translates to:
  /// **'Wij verzamelen medische gegevens via vragen of metingen die je doet. Bijvoorbeeld je gewicht of hartslag.'**
  String get onboardingConditionsItem1;

  /// Conditions Summary bullet item 2
  ///
  /// In nl, this message translates to:
  /// **'Je gegevens zijn te zien voor de verpleegkundigen en je behandelaar.'**
  String get onboardingConditionsItem2;

  /// Conditions Summary bullet item 3
  ///
  /// In nl, this message translates to:
  /// **'Je gegevens worden veilig opgeslagen.'**
  String get onboardingConditionsItem3;

  /// Conditions Summary read all conditions button
  ///
  /// In nl, this message translates to:
  /// **'Lees alle voorwaarden'**
  String get onboardingConditionsReadAllButton;

  /// Conditions agree button
  ///
  /// In nl, this message translates to:
  /// **'Ik ga akkoord'**
  String get onboardingConditionsAgreeButton;

  /// Validate information button
  ///
  /// In nl, this message translates to:
  /// **'Gegevens kloppen'**
  String get onboardingValidateInformationValidateButton;

  /// Terms and Conditions Header
  ///
  /// In nl, this message translates to:
  /// **'Complete voorwaarden'**
  String get termsAndConditionsHeader;

  /// Onboarding login information header
  ///
  /// In nl, this message translates to:
  /// **'We controleren je account'**
  String get onboardingLoginHeader;

  /// Onboarding login information paragraph
  ///
  /// In nl, this message translates to:
  /// **'Om de app te gebruiken, vul hier de code in die je hebt ontvangen en je geboortedatum. Zo zorgen we ervoor dat jouw account klopt en veilig is.'**
  String get onboardingLoginParagraph;

  /// Enter the code
  ///
  /// In nl, this message translates to:
  /// **'Vul de code in'**
  String get loginCodeHeader;

  /// Birth date accessible label
  ///
  /// In nl, this message translates to:
  /// **'Geboortedatum'**
  String get birthDateAccessibleLabel;

  /// Enter your birth date
  ///
  /// In nl, this message translates to:
  /// **'Vul je geboortedatum in (dd-mm-jjjj)'**
  String get birthDateHeader;

  /// Birth date example
  ///
  /// In nl, this message translates to:
  /// **'bijv. 09-12-1981'**
  String get birthDateExample;

  /// Onboarding login information to show login information
  ///
  /// In nl, this message translates to:
  /// **'Waar kan ik de code vinden?'**
  String get onboardingShowLoginInformationButton;

  /// Onboarding login information to see where is the code
  ///
  /// In nl, this message translates to:
  /// **'Waar kan ik de code vinden?'**
  String get loginInformationHeader;

  /// Birth date incomplete
  ///
  /// In nl, this message translates to:
  /// **'Vul alsjeblieft je geboortedatum in.'**
  String get birthDateIncomplete;

  /// Login code is incomplete
  ///
  /// In nl, this message translates to:
  /// **'Vul alsjeblieft je code in.'**
  String get loginCodeIncomplete;

  /// Login code is wrong
  ///
  /// In nl, this message translates to:
  /// **'Sorry, we herkennen deze code niet. Controleer of je het goed hebt ingevuld.'**
  String get loginCodeWrong;

  /// Login authentication error title
  ///
  /// In nl, this message translates to:
  /// **'Dit account wordt niet herkend'**
  String get loginAuthenticationErrorTitle;

  /// Login authentication error message
  ///
  /// In nl, this message translates to:
  /// **'Controleer of je de code en je geboortedatum goed hebt ingevuld en probeer het opnieuw. Werkt het nog steeds niet? Bel dan het Medisch Service Centrum op +31 6 0192837.'**
  String get loginAuthenticationErrorMessage;

  /// Unexpected error title to the patient
  ///
  /// In nl, this message translates to:
  /// **'Onverwachte fout opgetreden'**
  String get unexpectedErrorTitle;

  /// Unexpected error message to the patient
  ///
  /// In nl, this message translates to:
  /// **'Er is een onverwachte fout opgetreden. Controleer je internet verbinding en probeer het opnieuw.'**
  String get unexpectedErrorMessage;

  /// Onboarding Getting Started header to tell about the next steps
  ///
  /// In nl, this message translates to:
  /// **'Download de Thuismeten app om te beginnen'**
  String get onboardingGettingStartedHeader;

  /// Onboarding Getting Started paragraph 1
  ///
  /// In nl, this message translates to:
  /// **'De laatste stap is zorgen dat je de Thuismeten-app geïnstalleerd hebt staan op je telefoon.'**
  String get onboardingGettingStartedParagraph1;

  /// Onboarding Getting Started paragraph 2
  ///
  /// In nl, this message translates to:
  /// **'Heb je de Thuismeten-app al geïnstalleerd? Ga dan direct aan de slag met meten in de Zorg bij jou-app.'**
  String get onboardingGettingStartedParagraph2;

  /// Onboarding Getting Started paragraph 3
  ///
  /// In nl, this message translates to:
  /// **'Nog niet de Thuismeten-app geïnstalleerd? Check je e-mail (ook ongewenste e-mail) voor de uitnodiging van Luscii, de ontwikkelaar van de Thuismeten-app, en volg de instructies.'**
  String get onboardingGettingStartedParagraph3;

  /// Getting started button
  ///
  /// In nl, this message translates to:
  /// **'Begrepen'**
  String get onboardingGettingStartedButton;

  /// Onboarding Multiple Apps Introduction header to tell about usage of multiple apps
  ///
  /// In nl, this message translates to:
  /// **'Welkom! Samen houden we jouw gezondheid in de gaten'**
  String get onboardingMultipleAppsIntroductionHeader;

  /// Onboarding Multiple Apps Introduction paragraph to tell about usage of multiple apps
  ///
  /// In nl, this message translates to:
  /// **'Voor je behandeling heb je twee apps nodig. We leggen je graag uit wat je met deze apps kan.'**
  String get onboardingMultipleAppsIntroductionParagraph;

  /// Onboarding Multiple Apps Introduction image to show the two app icons
  ///
  /// In nl, this message translates to:
  /// **'Afbeelding van twee app-iconen: de eerste met de naam \'Zorg bij jou\' en de tweede met de naam \'Thuismeten\'.'**
  String get onboardingMultipleAppsIntroductionImage;

  /// Onboarding Multiple Apps Zorg bij jou header
  ///
  /// In nl, this message translates to:
  /// **'Zorg bij jou'**
  String get onboardingMultipleAppsZorgBijJouHeader;

  /// Onboarding Multiple Apps Zorg bij jou paragraph
  ///
  /// In nl, this message translates to:
  /// **'De Zorg bij jou app (deze app) gebruik je voor:'**
  String get onboardingMultipleAppsZorgBijJouParagraph;

  /// Onboarding Multiple Apps Zorg bij jou item 1 title
  ///
  /// In nl, this message translates to:
  /// **'Contact met verpleegkundigen.'**
  String get onboardingMultipleAppsZorgBijJouItem1Title;

  /// Onboarding Multiple Apps Zorg bij jou item 1 description
  ///
  /// In nl, this message translates to:
  /// **'Heb je zorgen over een meting of andere gezondheidsvragen? Je kunt contact opnemen met de verpleegkundige via deze app. Ook nemen zij contact met jou op bij vragen.'**
  String get onboardingMultipleAppsZorgBijJouItem1Description;

  /// Onboarding Multiple Apps Zorg bij jou item 2 title
  ///
  /// In nl, this message translates to:
  /// **'Hulp bij vragen.'**
  String get onboardingMultipleAppsZorgBijJouItem2Title;

  /// Onboarding Multiple Apps Zorg bij jou item 2 description
  ///
  /// In nl, this message translates to:
  /// **'Vind snel antwoorden op veelgestelde vragen over bijvoorbeeld het thuismeten en meer.'**
  String get onboardingMultipleAppsZorgBijJouItem2Description;

  /// Onboarding Multiple Apps Home Measurement header
  ///
  /// In nl, this message translates to:
  /// **'Thuismeten'**
  String get onboardingMultipleAppsHomeMeasurementHeader;

  /// Onboarding Multiple Apps Home Measurement paragraph
  ///
  /// In nl, this message translates to:
  /// **'De Thuismeten app helpt je bij het in de gaten houden van je gezondheid:'**
  String get onboardingMultipleAppsHomeMeasurementParagraph;

  /// Onboarding Multiple Apps Home Measurement item 1 title
  ///
  /// In nl, this message translates to:
  /// **'Zelf metingen doorgeven.'**
  String get onboardingMultipleAppsHomeMeasurementItem1Title;

  /// Onboarding Multiple Apps Home Measurement item 1 description
  ///
  /// In nl, this message translates to:
  /// **'Geef je gemeten waardes door, zoals je bloedglucose, om je diabetes in de gaten te houden.'**
  String get onboardingMultipleAppsHomeMeasurementItem1Description;

  /// Onboarding Multiple Apps Home Measurement item 2 title
  ///
  /// In nl, this message translates to:
  /// **'Krijg advies.'**
  String get onboardingMultipleAppsHomeMeasurementItem2Title;

  /// Onboarding Multiple Apps Home Measurement item 2 description
  ///
  /// In nl, this message translates to:
  /// **'Met jouw antwoorden en metingen geeft de app je meteen feedback en advies om je diabetes onder controle te houden.'**
  String get onboardingMultipleAppsHomeMeasurementItem2Description;

  /// Go Back button
  ///
  /// In nl, this message translates to:
  /// **'Terug'**
  String get backButton;

  /// Next button accessibility label
  ///
  /// In nl, this message translates to:
  /// **'Ga verder'**
  String get nextButtonAccessibilityLabel;

  /// Status bar accessibility label to show the current page and the total pages
  ///
  /// In nl, this message translates to:
  /// **'Stap {currentPage} van {totalPages}, actief'**
  String statusBarAccessibilityLabel(int currentPage, int totalPages);

  /// Service
  ///
  /// In nl, this message translates to:
  /// **'Service'**
  String get bottomNavigationService;

  /// Conversation
  ///
  /// In nl, this message translates to:
  /// **'Gesprek'**
  String get conversationTitle;

  /// no conversations in overview
  ///
  /// In nl, this message translates to:
  /// **'Geen gesprekken'**
  String get noConversations;

  /// New message
  ///
  /// In nl, this message translates to:
  /// **'Nieuw'**
  String get conversationNewMessage;

  /// Yesterday
  ///
  /// In nl, this message translates to:
  /// **'Gisteren'**
  String get conversationYesterday;

  /// Localized conversation time
  ///
  /// In nl, this message translates to:
  /// **'{datetime}'**
  String conversationTime(DateTime datetime);

  /// Localized conversation datetime
  ///
  /// In nl, this message translates to:
  /// **'{datetime}'**
  String conversationDateTime(DateTime datetime);

  /// Localized conversation date
  ///
  /// In nl, this message translates to:
  /// **'{date}'**
  String conversationDate(DateTime date);

  /// Avatar semantics label
  ///
  /// In nl, this message translates to:
  /// **'Avatar {name}'**
  String conversationAvatarSemanticLabel(String name);

  /// Conversation message from system user
  ///
  /// In nl, this message translates to:
  /// **'van de App'**
  String get conversationFromSystemSemanticLabel;

  /// Localized conversation semantic message
  ///
  /// In nl, this message translates to:
  /// **'Bericht van {user}. {message}. Ontvangen in {conversation} op {date} {time}.'**
  String conversationMessageSemanticLabel(String user, String message,
      String conversation, DateTime date, DateTime time);

  /// Localized conversation semantic message
  ///
  /// In nl, this message translates to:
  /// **'Bericht: {title}. {message}. {date} {time}.{unreadMessages, plural, =0{} =1{ 1 ongelezen bericht.} other{ {unreadMessages} ongelezen berichten.}}'**
  String conversationSemanticLabel(String title, String message, DateTime date,
      DateTime time, int unreadMessages);

  /// Localized conversation semantic message
  ///
  /// In nl, this message translates to:
  /// **'Bericht: {title}.{unreadMessages, plural, =0{} =1{ 1 ongelezen bericht.} other{ {unreadMessages} ongelezen berichten.}}'**
  String conversationNoMessageSemanticLabel(String title, int unreadMessages);

  /// Send conversation message accessibility label
  ///
  /// In nl, this message translates to:
  /// **'Bericht'**
  String get conversationSendMessageSemanticLabel;

  /// Title for the success notification banner in validate information
  ///
  /// In nl, this message translates to:
  /// **'Het is gelukt!'**
  String get validateInformationSuccessTitle;

  /// Content for the success notification banner in validate information
  ///
  /// In nl, this message translates to:
  /// **'Je account is met succes gecontroleerd.'**
  String get validateInformationSuccessContent;

  /// Text indicating recognized data in validate information
  ///
  /// In nl, this message translates to:
  /// **'We herkennen de volgende gegevens:'**
  String get validateInformationRecognizedData;

  /// Text indicating hospital and department in validate information
  ///
  /// In nl, this message translates to:
  /// **'Je ziekenhuis is het {hospitalName} en bent onder behandeling bij {departmentName}'**
  String validateInformationHospitalDepartment(
      String hospitalName, String departmentName);

  /// Text indicating treatment in validate information
  ///
  /// In nl, this message translates to:
  /// **'Je krijgt zorg voor {treatmentName}'**
  String validateInformationTreatment(String treatmentName);

  /// Text indicating patient name in validate information
  ///
  /// In nl, this message translates to:
  /// **'Je naam is {patientName}'**
  String validateInformationPatientName(String patientName);

  /// Button text for indicating incorrect information in validate information
  ///
  /// In nl, this message translates to:
  /// **'Klopt dit niet?'**
  String get validateInformationIncorrectButton;

  /// Next button text for indicating correct information in validate information
  ///
  /// In nl, this message translates to:
  /// **'Gegevens kloppen'**
  String get validateInformationNextButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
