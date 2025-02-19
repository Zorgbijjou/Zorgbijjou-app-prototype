import 'package:logging/logging.dart';

formatLogRecord(LogRecord record) {
  var timestamp = record.time.toUtc().toIso8601String();
  return '$timestamp [${record.level}] ${record.message}';
}
