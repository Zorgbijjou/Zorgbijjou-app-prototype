import 'package:logging/logging.dart';

import './log_record_formatting.dart';
import './zbj_logger.dart';

class ConsoleLogger implements ZbjLogger {
  final void Function(Object) printer;
  final Logger log = Logger('console');
  String userCode;

  ConsoleLogger({this.printer = print, this.userCode = ''});

  @override
  Future<ZbjLogger> initialize() {
    hierarchicalLoggingEnabled = true;
    log.level = Level.FINE;
    log.onRecord.listen((record) {
      printer(formatLogRecord(record));
    });

    log.fine('[ConsoleLogger] Console logger initialized');

    return Future.value(this);
  }

  @override
  updateUserCode(String code) {
    userCode = code;
  }

  @override
  void customEvent(String eventname,
      [Map<String, Object> data = const {}]) async {
    info('[Custom event][user-code:$userCode] $eventname: $data');
  }

  @override
  void pageview(
    String pagename, [
    Map<String, Object> data = const {},
    String? uri,
  ]) {
    info('[Pageview][user-code:$userCode] $pagename - $uri - $data');
  }

  @override
  void fine(String message) {
    log.fine(message);
  }

  @override
  void info(String message) {
    log.info(message);
  }

  @override
  void severe(String message) {
    log.severe(message);
  }

  @override
  void warning(String message) {
    log.warning(message);
  }
}
