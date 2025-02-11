import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLogger extends Mock implements ZbjLogger {}

void main() {
  group('Logger', () {
    setUp(() {
      getIt.reset();
    });

    test('log to registered logger', () async {
      var mockLogger = MockLogger();

      getIt.registerSingleton<ZbjLogger>(mockLogger);
      await getIt.allReady();

      customEvent('customEvent message', {'test': 'custom'});
      pageview('pageview message', {'test': 'page'}, 'page uri');
      fine('test', 'fine message');
      info('test', 'info message');
      warning('test', 'warning message');
      severe('test', 'severe message');
      await Future.delayed(const Duration(milliseconds: 100), () {});

      verify(() =>
          mockLogger.customEvent('customEvent message', {'test': 'custom'}));
      verify(() => mockLogger.pageview(
            'pageview message',
            {'test': 'page'},
            'page uri',
          ));
      verify(() => mockLogger.fine('[test] fine message'));
      verify(() => mockLogger.info('[test] info message'));
      verify(() => mockLogger.warning('[test] warning message'));
      verify(() => mockLogger.severe('[test] severe message'));
    });

    test('update user code of logger', () async {
      var mockLogger = MockLogger();

      getIt.registerSingleton<ZbjLogger>(mockLogger);

      await getIt.allReady();

      updateUserCode('new user code');

      await Future.delayed(const Duration(milliseconds: 100), () {});

      verify(() => mockLogger.updateUserCode('new user code')).called(1);
    });
  });
}
