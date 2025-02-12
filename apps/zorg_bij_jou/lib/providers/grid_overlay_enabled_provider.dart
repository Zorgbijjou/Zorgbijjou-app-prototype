import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gridOverlayEnabledProvider =
    StateNotifierProvider<GridOverlayEnabledNotifier, bool>((ref) {
  return GridOverlayEnabledNotifier();
});

class GridOverlayEnabledNotifier extends StateNotifier<bool> {
  final LocalStorage localStorage = getIt();

  GridOverlayEnabledNotifier() : super(false) {
    _initialize();
  }

  void _initialize() {
    loadGridOverlayEnabled();
  }

  void loadGridOverlayEnabled() {
    bool isGridOverlayEnabled = localStorage.loadGridOverlayEnabled();

    state = isGridOverlayEnabled;
  }

  Future<void> enableGridOverlay() async {
    await localStorage.storeGridOverlayEnabled(true);

    state = true;
  }

  Future<void> disableGridOverlay() async {
    await localStorage.storeGridOverlayEnabled(false);

    state = false;
  }

  void toggleGridOverlay() {
    if (state) {
      disableGridOverlay();
    } else {
      enableGridOverlay();
    }
  }
}
