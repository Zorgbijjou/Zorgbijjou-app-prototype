import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:theme/theme.dart';
import 'package:zorg_bij_jou/configuration/device_orientation_configuration.dart';
import 'package:zorg_bij_jou/locator.dart';
import 'package:zorg_bij_jou/providers/locale_provider.dart';
import 'package:zorg_bij_jou/routing/router.dart';

// coverage:ignore-start
bool _logError(dynamic error, [StackTrace? trace]) {
  severe('main', 'Unhandled error: $error');
  return false;
}

Future<void> main() async {
  FlutterError.onError = _logError;
  PlatformDispatcher.instance.onError = _logError;

  WidgetsFlutterBinding.ensureInitialized();

  var container = ProviderContainer();

  var initApp = setupLocator()
      .whenComplete(() => configureDeviceOrientation())
      .whenComplete(() => customEvent('App Started'));

  runApp(UncontrolledProviderScope(
    container: container,
    child: FutureBuilder(
      future: initApp,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? const MainAppConsumer()
              : const SizedBox(),
    ),
  ));
}

class MainAppConsumer extends ConsumerWidget {
  const MainAppConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var locale = ref.watch(localeProvider);
    var goRouter = ref.watch(goRouterProvider);

    return MainApp(router: goRouter, locale: locale);
  }
}

class MainApp extends StatelessWidget {
  final GoRouter router;
  final Locale locale;

  const MainApp({super.key, required this.router, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Tokens(
      tokens: DefaultTokens(),
      child: MaterialApp.router(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        routerConfig: router,
      ),
    );
  }
}
// coverage:ignore-end
