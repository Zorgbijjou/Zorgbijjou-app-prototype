import 'package:core/logging/console_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPrinter extends Mock {
  void call(Object? params);
}

void main() {
  group('ConsoleLogger', () {
    test('should print to console', () async {
      var mockPrinter = MockPrinter();
      var log = ConsoleLogger(printer: mockPrinter.call);

      await log.initialize();
      log.customEvent('customEvent message', {'test': 'custom'});
      log.pageview('pageview message', {'test': 'page'}, 'page uri');
      log.fine('fine message');
      log.info('info message');
      log.warning('warning message');
      log.severe('severe message');

      verify(() => mockPrinter.call(contains('test: custom')));
      verify(() => mockPrinter.call(contains('page uri')));
      verify(() => mockPrinter.call(contains('fine message')));
      verify(() => mockPrinter.call(contains('info message')));
      verify(() => mockPrinter.call(contains('warning message')));
      verify(() => mockPrinter.call(contains('severe message')));
    });
  });
}
