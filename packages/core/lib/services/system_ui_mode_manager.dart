import 'package:flutter/services.dart';

abstract class SystemUiModeManager {
  void setEnabledSystemUIMode(SystemUiMode mode,
      {List<SystemUiOverlay>? overlays});

  Future<void> setPreferredOrientations(List<DeviceOrientation> orientations);
}
