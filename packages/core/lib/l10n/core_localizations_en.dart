import 'package:intl/intl.dart' as intl;

import 'core_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get customerService => 'Customer service';

  @override
  String lastModified(DateTime date) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('d MMM y', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Last modified: $dateString';
  }

  @override
  String question(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions',
      one: '1 question',
      zero: 'no questions',
    );
    return '$_temp0';
  }

  @override
  String get questionsBySubject => 'Questions by subject';

  @override
  String get frequentlyAskedQuestions => 'Frequently asked questions';

  @override
  String get contactFooterHeader => 'Do you have a question?';

  @override
  String get contactFooterInformation =>
      'We are ready to help you. We are open on working days from 08:00 to 17:00.';

  @override
  String get contactFooterCallUs => 'Call us';

  @override
  String get contactFooterConversation => 'Start a conversation';

  @override
  String get faqMoreQuestions => 'More questions';

  @override
  String get contentNotAvailable =>
      'Unfortunately the text is not available at this time';

  @override
  String get noLusciiEmail =>
      'I have not received an e-mail from Luscii, now what?';

  @override
  String get noLusciiEmailIntroduction =>
      'You haven\'t received an e-mail? We\'re sorry. We will fix this step by step together with you';

  @override
  String get isHomeMeasurementFree =>
      'Is home measurement by Zorg bij jou free?';

  @override
  String get canIStopHomeMeasurement => 'Can I stop home measurement?';

  @override
  String get howDoesHomeMeasurementWork => 'How does home measurement work';

  @override
  String get beginHomeMeasurement =>
      'What do I need to do to start home monitoring?';

  @override
  String get whenDoesTheNurseRespond =>
      'When will the nurse respond to my message?';

  @override
  String get howIsMyPrivacy => 'What about my privacy?';

  @override
  String get whyShouldIKeepMeasuring =>
      'Why do I need to continue measuring, even if I feel fine?';

  @override
  String get howDoesHomeMeasurementAppWork =>
      'How does the home measurement app work?';

  @override
  String get homeMeasurementApp => 'Home measurement app';

  @override
  String get howDoIConductAMeasurement =>
      'How do I perform a measurement in the Home Monitoring app?';

  @override
  String get iDidNotReceiveAnInvitation =>
      'I haven’t received an invitation for the Home Monitoring app. What should I do?';

  @override
  String get howDoIStopNotifications =>
      'How can I ensure I don’t receive notifications during my vacation?';

  @override
  String get digitalAccessibilityHomeMeasurementsApp =>
      'Digital accessibility of the Home Monitoring app';

  @override
  String get digitalAccessibilityZorgBijJouApp =>
      'Digital accessibility of the Zorg bij jou app';

  @override
  String get doINeedTheHomeMeasurementsApp =>
      'Do I really need the Home Monitoring app?';

  @override
  String get doINeedTheZorgBijJouApp =>
      'Do I really need the Zorg bij jou app?';

  @override
  String get zorgBijJouApp => 'Zorg bij jou app';

  @override
  String get myHeartRateMonitor => 'My heart rate monitor';

  @override
  String get heartFailure => 'Heart failure';

  @override
  String get homeMeasurementWithHeartFailure =>
      'Home measurement with heart failure';

  @override
  String get zorgBijJou => 'Zorg bij jou';

  @override
  String get welcome => 'Welkom back';

  @override
  String get localAuthChallengeReason => 'Unlock the Zorgbijjou app';

  @override
  String get localAuthCancelButton => 'Back';

  @override
  String get localAuthChallengeAgain => 'Unlock the Zorgbijjou app';

  @override
  String get localAuthToOnboarding => 'Back to onboarding';

  @override
  String get onboardingConditionsHeader => 'We need your permission';

  @override
  String get onboardingConditionsExplanation =>
      'To use Zorg bij jou you have to agree with the conditions:';

  @override
  String get onboardingConditionsItem1 =>
      'We collect medical data through questions or measurements that you take. For example, your weight or hart beat.';

  @override
  String get onboardingConditionsItem2 =>
      'Your data is visible for doctors and medical practitioners.';

  @override
  String get onboardingConditionsItem3 => 'Your data will be stored securely.';

  @override
  String get onboardingConditionsReadAllButton => 'Read all conditions';

  @override
  String get onboardingConditionsAgreeButton => 'I agree';

  @override
  String get onboardingValidateInformationValidateButton =>
      'Information is correct';

  @override
  String get termsAndConditionsHeader => 'Complete Conditions';

  @override
  String get onboardingLoginHeader => 'Account check';

  @override
  String get onboardingLoginParagraph =>
      'To use the app, enter the code you received and your date of birth here. This way we ensure that your account is correct and safe.';

  @override
  String get loginCodeHeader => 'Enter your code';

  @override
  String get birthDateAccessibleLabel => 'Birth date';

  @override
  String get birthDateHeader => 'Enter your birth date (dd-mm-yyyy)';

  @override
  String get birthDateExample => 'E.g. 09-12-1981';

  @override
  String get onboardingShowLoginInformationButton =>
      'Where can I find the code?';

  @override
  String get loginInformationHeader => 'Where can I find the code?';

  @override
  String get birthDateIncomplete => 'Please enter your date of birth.';

  @override
  String get loginCodeIncomplete => 'Please enter your code.';

  @override
  String get loginCodeWrong =>
      'Sorry, we don\'t recognize the code. Check if you filled in the code correctly.';

  @override
  String get loginAuthenticationErrorTitle => 'This account is not recognized';

  @override
  String get loginAuthenticationErrorMessage =>
      'Check if your code and birth date are valid and retry. Do you keep getting this error? Call the Medisch Service Centrum on +31 6 0192837.';

  @override
  String get unexpectedErrorTitle => 'Unexpected error occurred.';

  @override
  String get unexpectedErrorMessage =>
      'There is an unexpected error. Check the internet connection and retry.';

  @override
  String get onboardingGettingStartedHeader =>
      'Download the Home Monitoring app to get started';

  @override
  String get onboardingGettingStartedParagraph1 =>
      'You can ask questions, view your treatment plan, and receive tips on how to work on your health.';

  @override
  String get onboardingGettingStartedParagraph2 =>
      'You can also measure your blood pressure, weight, and other values yourself. You will receive immediate feedback on your measurements.';

  @override
  String get onboardingGettingStartedParagraph3 =>
      'You can also ask the nurse questions or answer questions from the doctor.';

  @override
  String get onboardingGettingStartedButton => 'Understood';

  @override
  String get onboardingMultipleAppsIntroductionHeader =>
      'Welcome, together we will monitor your health';

  @override
  String get onboardingMultipleAppsIntroductionParagraph =>
      'You are using the Zorg bij jou app. This app is part of the Luscii platform. With this platform, you can monitor your health and communicate with your healthcare provider.';

  @override
  String get onboardingMultipleAppsIntroductionImage =>
      'Onboarding Multiple Apps Introduction image to show the two app icons';

  @override
  String get onboardingMultipleAppsZorgBijJouHeader => 'Zorg bij jou';

  @override
  String get onboardingMultipleAppsZorgBijJouParagraph =>
      'The Zorg bij jou app (this app) is used for:';

  @override
  String get onboardingMultipleAppsZorgBijJouItem1Title =>
      'Ask questions or answer questions';

  @override
  String get onboardingMultipleAppsZorgBijJouItem1Description =>
      'You can ask the nurse questions or answer questions from the doctor.';

  @override
  String get onboardingMultipleAppsZorgBijJouItem2Title =>
      'Receive explanations and tips';

  @override
  String get onboardingMultipleAppsZorgBijJouItem2Description =>
      'You will receive explanations about your treatment and tips on how to work on your health.';

  @override
  String get onboardingMultipleAppsHomeMeasurementHeader => 'Home measurement';

  @override
  String get onboardingMultipleAppsHomeMeasurementParagraph =>
      'The Home Monitoring app is used for:';

  @override
  String get onboardingMultipleAppsHomeMeasurementItem1Title =>
      'Measure yourself';

  @override
  String get onboardingMultipleAppsHomeMeasurementItem1Description =>
      'You can measure your blood pressure, weight, and other values yourself.';

  @override
  String get onboardingMultipleAppsHomeMeasurementItem2Title =>
      'Immediate feedback';

  @override
  String get onboardingMultipleAppsHomeMeasurementItem2Description =>
      'You will receive immediate feedback on your measurements.';

  @override
  String get backButton => 'Back';

  @override
  String get nextButtonAccessibilityLabel => 'Continue';

  @override
  String statusBarAccessibilityLabel(int currentPage, int totalPages) {
    return 'Step $currentPage from $totalPages, active';
  }

  @override
  String get bottomNavigationService => 'Service';

  @override
  String get conversationTitle => 'Conversation';

  @override
  String get noConversations => 'No conversations';

  @override
  String get conversationNewMessage => 'New';

  @override
  String get conversationYesterday => 'Yesterday';

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
  String get conversationFromSystemSemanticLabel => 'from the App';

  @override
  String conversationMessageSemanticLabel(String user, String message,
      String conversation, DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat =
        intl.DateFormat('dMMMMy', localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    return 'Message from $user. $message. Sent in $conversation at $dateString $timeString.';
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
      other: '$unreadMessages unread messages.',
      one: ' 1 unread message.',
      zero: '',
    );
    return 'Message: $title. $message. $dateString $timeString.$_temp0';
  }

  @override
  String conversationNoMessageSemanticLabel(String title, int unreadMessages) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadMessages,
      locale: localeName,
      other: ' $unreadMessages unread messages.',
      one: ' 1 unread message.',
      zero: '',
    );
    return 'Message: $title.$_temp0';
  }

  @override
  String get conversationSendMessageSemanticLabel => 'Message';

  @override
  String get validateInformationSuccessTitle => 'Success!';

  @override
  String get validateInformationSuccessContent =>
      'Your account has been successfully verified.';

  @override
  String get validateInformationRecognizedData =>
      'We recognize the following data:';

  @override
  String validateInformationHospitalDepartment(
      String hospitalName, String departmentName) {
    return 'Your hospital is $hospitalName and you are being treated at $departmentName';
  }

  @override
  String validateInformationTreatment(String treatmentName) {
    return 'You are receiving care for $treatmentName';
  }

  @override
  String validateInformationPatientName(String patientName) {
    return 'Your name is $patientName';
  }

  @override
  String get validateInformationIncorrectButton => 'Is this incorrect?';

  @override
  String get validateInformationNextButton => 'Next';
}
