import 'package:core/auth/auth_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late AuthImpl auth;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    auth = AuthImpl(storage: mockStorage);
  });

  test('should return access token ', () async {
    when(() => mockStorage.read(
            key: AuthImpl.accessTokenKey,
            iOptions: any(named: 'iOptions'),
            aOptions: any(named: 'aOptions')))
        .thenAnswer((_) async => 'valid-access-token');
    when(() => mockStorage.read(
            key: AuthImpl.accessTokenValidUntilKey,
            iOptions: any(named: 'iOptions'),
            aOptions: any(named: 'aOptions')))
        .thenAnswer((_) async =>
            DateTime.now().add(const Duration(minutes: 5)).toIso8601String());

    String token = await auth.getAccessToken();

    expect(token, 'valid-access-token');
  });

  test('should throw exception if no refresh token found', () async {
    when(() => mockStorage.read(
        key: AuthImpl.accessTokenKey,
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async => null);
    when(() => mockStorage.read(
        key: AuthImpl.accessTokenValidUntilKey,
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async => null);
    when(() => mockStorage.read(
        key: AuthImpl.refreshTokenKey,
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async => null);

    expect(() => auth.getAccessToken(), throwsException);
  });

  test('should store new access token if current is invalid', () async {
    when(() => mockStorage.read(
        key: AuthImpl.accessTokenKey,
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async => null);
    when(() => mockStorage.read(
        key: AuthImpl.accessTokenValidUntilKey,
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async => null);
    when(() => mockStorage.read(
            key: AuthImpl.refreshTokenKey,
            iOptions: any(named: 'iOptions'),
            aOptions: any(named: 'aOptions')))
        .thenAnswer((_) async => 'refresh-token');

    when(() => mockStorage.write(
        key: AuthImpl.accessTokenKey,
        value: 'cmVmcmVzaC10b2tlbg==',
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async {});
    when(() => mockStorage.write(
        key: AuthImpl.accessTokenValidUntilKey,
        value: any(named: 'value'),
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async {});

    String token = await auth.getAccessToken();

    expect(token, isNotNull);
  });

  test('should store refresh token on login', () async {
    when(() => mockStorage.write(
        key: AuthImpl.refreshTokenKey,
        value: 'patientCode',
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async {});

    await auth.login('patientCode', 'birthdate');

    verify(() => mockStorage.write(
        key: AuthImpl.refreshTokenKey,
        value: 'patientCode',
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).called(1);
  });

  test('should delete tokens on logout', () async {
    when(() => mockStorage.delete(
        key: AuthImpl.accessTokenKey,
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async {});
    when(() => mockStorage.delete(
        key: AuthImpl.accessTokenValidUntilKey,
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async {});
    when(() => mockStorage.delete(
        key: AuthImpl.refreshTokenKey,
        iOptions: any(named: 'iOptions'),
        aOptions: any(named: 'aOptions'))).thenAnswer((_) async {});

    await auth.logout();

    verify(() => mockStorage.delete(key: AuthImpl.refreshTokenKey)).called(1);
    verify(() => mockStorage.delete(key: AuthImpl.accessTokenKey)).called(1);
    verify(() => mockStorage.delete(key: AuthImpl.accessTokenValidUntilKey))
        .called(1);
  });
}
