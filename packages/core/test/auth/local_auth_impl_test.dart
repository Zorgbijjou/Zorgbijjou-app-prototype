import 'package:core/auth/local_auth_impl.dart';
import 'package:core/locator/locator.dart';
import 'package:core/logging/zbj_logger.dart';
import 'package:core/mocks/mock_logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class AuthenticationOptionsFake extends Fake implements AuthenticationOptions {}

class AndroidAuthMessagesFake extends Fake implements AndroidAuthMessages {}

class IOSAuthMessagesFake extends Fake implements IOSAuthMessages {}

void main() {
  late LocalAuthImpl localAuthImpl;
  late MockLocalAuthentication mockLocalAuthentication;

  setUpAll(() {
    registerFallbackValue(AuthenticationOptionsFake());
    registerFallbackValue(AndroidAuthMessagesFake());
    registerFallbackValue(IOSAuthMessagesFake());
    getIt.registerSingleton<ZbjLogger>(MockLogger());
  });

  setUp(() {
    mockLocalAuthentication = MockLocalAuthentication();
    localAuthImpl = LocalAuthImpl(localAuth: mockLocalAuthentication);
  });

  test('should return true when authentication is successful', () async {
    when(() => mockLocalAuthentication.authenticate(
          localizedReason: any(named: 'localizedReason'),
          options: any(named: 'options'),
          authMessages: any(named: 'authMessages'),
        )).thenAnswer((_) async => true);

    bool result = await localAuthImpl.isLocallyAuthenticated(
      challengeReason: 'reason',
      cancelButton: 'cancel',
    );

    expect(result, true);
  });

  test('should return false when authentication fails', () async {
    when(() => mockLocalAuthentication.authenticate(
          localizedReason: any(named: 'localizedReason'),
          options: any(named: 'options'),
          authMessages: any(named: 'authMessages'),
        )).thenAnswer((_) async => false);

    bool result = await localAuthImpl.isLocallyAuthenticated(
      challengeReason: 'reason',
      cancelButton: 'cancel',
    );

    expect(result, false);
  });

  test(
      'should return true when PlatformException is notAvailable or otherOperatingSystem',
      () async {
    when(() => mockLocalAuthentication.authenticate(
          localizedReason: any(named: 'localizedReason'),
          options: any(named: 'options'),
          authMessages: any(named: 'authMessages'),
        )).thenThrow(PlatformException(code: 'NotAvailable'));

    bool result = await localAuthImpl.isLocallyAuthenticated(
      challengeReason: 'reason',
      cancelButton: 'cancel',
    );

    expect(result, true);
  });

  test(
      'should return false when PlatformException is lockedOut or permanentlyLockedOut',
      () async {
    when(() => mockLocalAuthentication.authenticate(
          localizedReason: any(named: 'localizedReason'),
          options: any(named: 'options'),
          authMessages: any(named: 'authMessages'),
        )).thenThrow(PlatformException(code: 'LockedOut'));

    bool result = await localAuthImpl.isLocallyAuthenticated(
      challengeReason: 'reason',
      cancelButton: 'cancel',
    );

    expect(result, false);
  });

  test('should return false and log error for other PlatformException',
      () async {
    when(() => mockLocalAuthentication.authenticate(
          localizedReason: any(named: 'localizedReason'),
          options: any(named: 'options'),
          authMessages: any(named: 'authMessages'),
        )).thenThrow(PlatformException(code: 'OtherError'));

    bool result = await localAuthImpl.isLocallyAuthenticated(
      challengeReason: 'reason',
      cancelButton: 'cancel',
    );

    expect(result, false);
  });
}
