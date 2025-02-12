abstract class LocalAuth {
  Future<bool> isLocallyAuthenticated({
    required String challengeReason,
    required String cancelButton,
  });
}
