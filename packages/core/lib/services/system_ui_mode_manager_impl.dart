// coverage:ignore-file

import 'package:core/services/system_ui_mode_manager.dart';
import 'package:flutter/services.dart';

class SystemUiModeManagerImpl implements SystemUiModeManager {
  @override
  void setEnabledSystemUIMode(SystemUiMode mode,
      {List<SystemUiOverlay>? overlays}) {
    SystemChrome.setEnabledSystemUIMode(mode, overlays: overlays);
  }

  @override
  Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }
}
