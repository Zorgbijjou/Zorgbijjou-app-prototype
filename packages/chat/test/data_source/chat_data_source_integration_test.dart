import 'package:core/locator/locator.dart';
import 'package:core/logging/console_logger.dart';
import 'package:core/logging/zbj_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Chat integrations test', () {
    setUpAll(() {
      getIt.registerSingletonAsync<ZbjLogger>(
          () => ConsoleLogger(printer: print).initialize(),
          instanceName: 'console');
    });
    //
    // ChatDataSourceImpl dataSource = ChatDataSourceImpl(
    //     host: 'http://localhost:5178', client: http.Client());
    //
    // test('test', () async {
    //   String patientCode = 'ZBJFTW';
    //
    //   List<Conversation> result =
    //       await dataSource.fetchConversations(patientCode);
    //
    //   expect(result, isA<List<Conversation>>());
    //   expect(result.length, 1);
    // });
  });
}
