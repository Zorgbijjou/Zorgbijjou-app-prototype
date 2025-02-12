import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

materialAppWithTokens({
  required Widget child,
  ITokens? tokens,
  required WidgetTester tester,
}) {
  return MediaQuery(
      data: MediaQueryData(size: tester.view.physicalSize),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Tokens(tokens: tokens ?? DefaultTokens(), child: child),
      ));
}

class MockGoRouter extends Mock implements GoRouter {}

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.goRouter,
    required this.child,
    super.key,
  });

  /// The mock navigator used to mock navigation calls.
  final MockGoRouter goRouter;

  /// The child [Widget] to render.
  final Widget child;

  @override
  Widget build(BuildContext context) => InheritedGoRouter(
        goRouter: goRouter,
        child: child,
      );
}

// Mock the StatefulNavigationShell class
class MockStatefulNavigationShell extends Mock
    implements StatefulNavigationShell {
  final StatefulWidget widget;

  MockStatefulNavigationShell({required this.widget});

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }

  @override
  StatefulElement createElement() {
    return StatefulElement(widget);
  }

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return widget.createState();
  }
}

final tabletViewSize = const Size(820, 1180);
final phoneViewSize = const Size(432, 932);

class MockAuth extends Mock implements Auth {}

class MockLocalAuth extends Mock implements LocalAuth {}

void ignoreRenderFlexException() {
  var originalOnError = FlutterError.onError!;
  FlutterError.onError = (FlutterErrorDetails data) {
    if (data.library == 'rendering library') {
      return;
    }
    originalOnError(data);
  };
}
