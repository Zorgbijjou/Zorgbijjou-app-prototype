import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final devModeProvider = StateNotifierProvider<DevModeNotifier, bool>((ref) {
  return DevModeNotifier();
});

class DevModeNotifier extends StateNotifier<bool> {
  final LocalStorage devModeStorage = getIt();

  DevModeNotifier() : super(false) {
    _initialize();
  }

  void _initialize() {
    loadDevMode();
  }

  void loadDevMode() {
    bool isDevMode = devModeStorage.loadDevMode();

    state = isDevMode;
  }

  Future<void> enableDevMode() async {
    await devModeStorage.storeDevMode(true);

    state = true;
  }

  Future<void> disableDevMode() async {
    await devModeStorage.storeDevMode(false);

    state = false;
  }
}
