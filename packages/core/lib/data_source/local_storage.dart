import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late final SharedPreferences preferences;

  static const String loginCodeKey = 'login-code';
  static const String onboardingFinishedKey = 'onboarding-finished';
  static const String devModeKey = 'dev-mode';
  static const String gridOverlayEnabledKey = 'grid-overlay-enabled';
  static const String localAuthEnabledKey = 'local-auth-enabled';

  Future<void> initialize() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> storeCode(String code) async {
    await preferences.setString(loginCodeKey, code);
  }

  String? getCode() {
    return preferences.getString(loginCodeKey);
  }

  Future<void> storeFinishedOnboarding() async {
    await preferences.setBool(onboardingFinishedKey, true);
  }

  bool isOnboardingFinished() {
    return preferences.getBool(onboardingFinishedKey) ?? false;
  }

  Future<void> clearOnboarding() async {
    await preferences.remove(onboardingFinishedKey);
  }

  bool loadDevMode() {
    return preferences.getBool(devModeKey) ?? false;
  }

  Future<void> storeDevMode(bool devMode) async {
    await preferences.setBool(devModeKey, devMode);
  }

  Future<void> storeGridOverlayEnabled(bool bool) async {
    await preferences.setBool(gridOverlayEnabledKey, bool);
  }

  bool loadGridOverlayEnabled() {
    return preferences.getBool(gridOverlayEnabledKey) ?? false;
  }

  Future<void> storeLocalAuthEnabled(bool bool) async {
    await preferences.setBool(localAuthEnabledKey, bool);
  }

  bool loadLocalAuthEnabled() {
    return preferences.getBool(localAuthEnabledKey) ?? false;
  }
}
