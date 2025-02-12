import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    ITokens tokens = DefaultTokens();

    return Widgetbook.material(
      directories: directories,
      addons: [
        BuilderAddon(
            name: 'Tokens',
            builder: (context, child) => Tokens(tokens: tokens, child: child)),
        DeviceFrameAddon(devices: [
          Devices.ios.iPhoneSE,
          Devices.ios.iPhone13,
          Devices.ios.iPad,
          Devices.android.samsungGalaxyA50,
          Devices.android.samsungGalaxyS20,
        ]),
        InspectorAddon(),
        AlignmentAddon(initialAlignment: Alignment.center),
        LocalizationAddon(
          locales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          initialLocale: AppLocalizations.supportedLocales.last,
        ),
      ],
    );
  }
}
