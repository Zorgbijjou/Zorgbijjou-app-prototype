import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme/theme.dart';

Future<void> configureDeviceOrientation() async {
  MediaQueryData data = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single);

  var systemUiModeManager = getIt<SystemUiModeManager>();

  if (data.isTabletView()) {
    // Allow both portrait and landscape for tablets
    await systemUiModeManager.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } else {
    // Restrict to portrait only for mobile devices
    await systemUiModeManager.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
