import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localAuthEnabledProvider =
    StateNotifierProvider<LocalAuthEnabledNotifier, bool>((ref) {
  return LocalAuthEnabledNotifier();
});

class LocalAuthEnabledNotifier extends StateNotifier<bool> {
  final LocalStorage localStorage = getIt();

  LocalAuthEnabledNotifier() : super(false) {
    _initialize();
  }

  void _initialize() {
    loadLocalAuthEnabled();
  }

  void loadLocalAuthEnabled() {
    bool isLocalAuthEnabled = localStorage.loadLocalAuthEnabled();

    state = isLocalAuthEnabled;
  }

  Future<void> enableLocalAuth() async {
    await localStorage.storeLocalAuthEnabled(true);

    state = true;
  }

  Future<void> disableLocalAuth() async {
    await localStorage.storeLocalAuthEnabled(false);

    state = false;
  }

  void toggleLocalAuth() {
    if (state) {
      disableLocalAuth();
    } else {
      enableLocalAuth();
    }
  }
}
