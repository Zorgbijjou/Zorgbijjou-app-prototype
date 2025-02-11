import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zorg_bij_jou/configuration/device_orientation_configuration.dart';

class MockSystemUiModeManager extends Mock implements SystemUiModeManager {}

void main() {
  late MockSystemUiModeManager mockSystemUiModeManager;

  group('configureDeviceOrientation', () {
    setUp(() {
      mockSystemUiModeManager = MockSystemUiModeManager();
      getIt.registerSingleton<SystemUiModeManager>(mockSystemUiModeManager);

      when(() => mockSystemUiModeManager.setPreferredOrientations(any()))
          .thenAnswer((_) async {});
    });

    tearDown(() {
      getIt.reset();
    });

    testWidgets('sets preferred orientations for tablets',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpAndSettle();

      await configureDeviceOrientation();

      verify(() => mockSystemUiModeManager.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ])).called(1);
    });

    testWidgets('sets preferred orientations for mobile devices',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await configureDeviceOrientation();

      verify(() => mockSystemUiModeManager.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ])).called(1);
    });
  });
}
