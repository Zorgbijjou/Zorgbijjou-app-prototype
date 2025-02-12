import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class LocalAuthImpl extends LocalAuth {
  final LocalAuthentication localAuth;

  LocalAuthImpl({required this.localAuth});

  @override
  Future<bool> isLocallyAuthenticated({
    required String challengeReason,
    required String cancelButton,
  }) async {
    try {
      bool didAuthenticate = await localAuth.authenticate(
        localizedReason: challengeReason,
        options: const AuthenticationOptions(),
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: challengeReason,
            cancelButton: cancelButton,
          ),
          IOSAuthMessages(
            cancelButton: cancelButton,
          ),
        ],
      );

      return didAuthenticate;
    } on MissingPluginException catch (e) {
      fine('Local auth not available', '$e');
      return true;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable ||
          e.code == auth_error.otherOperatingSystem) {
        fine('Local auth not supported', '$e');
        return true;
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
      } else {
        severe('Local auth failed', '$e');
        customEvent('Local authentication failed', {'error': '$e'});
      }

      return false;
    }
  }
}
