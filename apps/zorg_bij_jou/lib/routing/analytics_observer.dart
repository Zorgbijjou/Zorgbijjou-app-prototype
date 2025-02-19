import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

String getScreenName(RouteSettings settings) {
  String result = settings.name ?? '';

  var argMap = settings.arguments;
  if (argMap is Map) {
    for (var key in argMap.keys) {
      result = result.replaceAll(':$key', argMap[key]!);
    }
  }

  return result;
}

bool isPageRoute(Route<dynamic>? route) {
  return route != null && route is PageRoute;
}

bool isCurrentPageRoute(Route<dynamic>? route) {
  var routeName = route?.settings.name ?? '';

  return isPageRoute(route) &&
      route != null &&
      routeName.isNotEmpty &&
      route.isCurrent;
}

class AnalyticsObserver extends RouteObserver<ModalRoute<dynamic>> {
  _logPageView(Route route) async {
    var args = route.settings.arguments;
    Map<String, Object> data = {};

    if (args is Map) {
      data =
          args.map((key, value) => MapEntry(key.toString(), value as Object));
    }

    var screenName = getScreenName(route.settings);
    pageview(screenName, data);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    if (isCurrentPageRoute(route)) {
      _logPageView(
        route,
      );
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (isPageRoute(newRoute)) {
      _logPageView(newRoute!);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    if (isPageRoute(previousRoute) && isPageRoute(route)) {
      _logPageView(previousRoute!);
    }
  }
}
