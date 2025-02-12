import 'package:core/logging/log_record_formatting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

void main() {
  group('LogRecordFormatting', () {
    test('should format LogRecords', () {
      var record = LogRecord(Level.INFO, 'test message', 'console-logger');

      var formatted = formatLogRecord(record);

      expect(formatted,
          '${record.time.toUtc().toIso8601String()} [INFO] test message');
    });
  });
}
