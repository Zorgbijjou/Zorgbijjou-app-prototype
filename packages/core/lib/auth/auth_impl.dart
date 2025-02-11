import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth.dart';

class AuthImpl extends Auth {
  static const String refreshTokenKey = 'refresh-token';
  static const String accessTokenKey = 'access-token';
  static const String accessTokenValidUntilKey = 'access-token-valid-until';

  final FlutterSecureStorage storage;
  final Map<String, String> _cache = {};

  AuthImpl({required this.storage});

  @override
  Future<bool> hasRefreshToken() async {
    String? refreshToken = await _readValue(refreshTokenKey);
    return refreshToken != null;
  }

  @override
  Future<String> getAccessToken() async {
    String? accessToken = await _readValue(accessTokenKey);
    String? accessTokenValid = await _readValue(accessTokenValidUntilKey);

    if (accessTokenValid == null /* || accessToken is expired*/ ||
        accessToken == null) {
      // fetch token from storage
      String? refreshToken = await _readValue(refreshTokenKey);
      if (refreshToken == null) {
        return throw Exception('No refresh token found');
      }

      // fetch access token from backend
      accessToken = base64.encode(utf8.encode(refreshToken));
      String accessTokenValid =
          DateTime.now().add(const Duration(minutes: 5)).toIso8601String();

      await _writeValue(accessTokenKey, accessToken);
      await _writeValue(accessTokenValidUntilKey, accessTokenValid);
    }

    return accessToken;
  }

  @override
  Future<void> login(String patientCode, String birthdate) async {
    // login call to backend /auth
    String refreshToken = patientCode;

    _cache[refreshTokenKey] = refreshToken;
    await _writeValue(refreshTokenKey, refreshToken);
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: refreshTokenKey);
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: accessTokenValidUntilKey);
  }

  Future<String?> _readValue(String key) async {
    String? value = await storage.read(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    return value;
  }

  Future<void> _writeValue(String key, String value) async {
    storage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  IOSOptions _getIOSOptions() => const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
        synchronizable: true,
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
