import 'package:core/core.dart';

customEvent(String eventname, [Map<String, Object> data = const {}]) {
  getIt.getAllAsync<ZbjLogger>().then((loggers) {
    for (var logger in loggers) {
      logger.customEvent(eventname, data);
    }
  });
}

pageview(String pagename, [Map<String, Object> data = const {}, String? uri]) {
  getIt.getAllAsync<ZbjLogger>().then((loggers) {
    for (var logger in loggers) {
      logger.pageview(pagename, data, uri);
    }
  });
}

fine(String category, String message) {
  getIt.getAllAsync<ZbjLogger>().then((loggers) {
    for (var logger in loggers) {
      logger.fine('[$category] $message');
    }
  });
}

info(String category, String message) {
  getIt.getAllAsync<ZbjLogger>().then((loggers) {
    for (var logger in loggers) {
      logger.info('[$category] $message');
    }
  });
}

warning(String category, String message) {
  getIt.getAllAsync<ZbjLogger>().then((loggers) {
    for (var logger in loggers) {
      logger.warning('[$category] $message');
    }
  });
}

severe(String category, String message) {
  getIt.getAllAsync<ZbjLogger>().then((loggers) {
    for (var logger in loggers) {
      logger.severe('[$category] $message');
    }
  });
}

updateUserCode(String code) {
  getIt.getAllAsync<ZbjLogger>().then((loggers) {
    for (var logger in loggers) {
      logger.updateUserCode(code);
    }
  });
}
