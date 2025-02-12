import 'package:core/data_source/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('Onboarding finished is saved', () async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});

    LocalStorage storage = LocalStorage();
    await storage.initialize();

    expect(storage.isOnboardingFinished(), false);
    await storage.storeFinishedOnboarding();
    expect(storage.isOnboardingFinished(), true);
  });

  test('Onboarding code is saved', () async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});

    LocalStorage storage = LocalStorage();
    await storage.initialize();

    expect(storage.getCode(), null);
    await storage.storeCode('code');
    expect(storage.getCode(), 'code');
  });

  // test grid overlay
  test('Grid overlay is enabled', () async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});

    LocalStorage storage = LocalStorage();
    await storage.initialize();

    expect(storage.loadGridOverlayEnabled(), false);
    await storage.storeGridOverlayEnabled(true);
    expect(storage.loadGridOverlayEnabled(), true);
  });

  test('Dev mode is enabled', () async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});

    LocalStorage storage = LocalStorage();
    await storage.initialize();

    expect(storage.loadDevMode(), false);
    await storage.storeDevMode(true);
    expect(storage.loadDevMode(), true);
  });
}
