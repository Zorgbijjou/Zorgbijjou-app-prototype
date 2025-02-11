import 'package:azure_application_insights/azure_application_insights.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTelemetryClient extends Mock implements TelemetryClient {
  void call(Object? params);
}

class MockPrinter extends Mock {
  void call(Object? params);
}

void main() {
  group('AppInsightsLogger', () {
    test('should initialize a telemetry client', () async {
      var mockPrinter = MockPrinter();
      var log = AppInsightsLogger(
        userCode: 'user code',
        instrumentationKey: 'some key',
        sessionId: 'test session',
        printer: mockPrinter.call,
      );

      await log.initialize();

      expect(log.client, isNotNull);
      expect(log.telemetryClient, isNotNull);
    });

    test('should log track events in app insights', () {
      var mockPrinter = MockPrinter();
      var log = AppInsightsLogger(
        userCode: 'user code',
        instrumentationKey: 'some key',
        sessionId: 'test session',
        printer: mockPrinter.call,
      );
      var mockTelemetryClient = MockTelemetryClient();

      log.telemetryClient = mockTelemetryClient;

      log.customEvent('customEvent message', {'test': 'custom'});
      log.pageview('pageview message', {'test': 'pageview'}, 'page uri');
      log.fine('fine message');
      log.info('info message');
      log.warning('warning message');
      log.severe('severe message');

      verify(() => mockTelemetryClient.trackEvent(
          name: 'customEvent message',
          additionalProperties: {'test': 'custom'}));
      verify(() => mockTelemetryClient.trackPageView(
            name: 'pageview message',
            url: 'page uri',
            additionalProperties: {'test': 'pageview'},
          ));
      verifyNever(() => mockTelemetryClient.trackTrace(
          severity: Severity.verbose, message: 'fine message'));
      verify(() => mockTelemetryClient.trackTrace(
          severity: Severity.information, message: 'info message'));
      verify(() => mockTelemetryClient.trackTrace(
          severity: Severity.warning, message: 'warning message'));
      verify(() => mockTelemetryClient.trackError(
          severity: Severity.critical, error: 'severe message'));
    });

    test('should update the user code', () async {
      var mockPrinter = MockPrinter();
      var log = AppInsightsLogger(
        userCode: 'user code',
        instrumentationKey: 'some key',
        sessionId: 'test session',
        printer: mockPrinter.call,
      );

      await log.initialize();

      expect(log.telemetryClient!.context.user.id, 'user code');

      log.updateUserCode('new user code');

      expect(log.telemetryClient!.context.user.id, 'new user code');
    });
  });
}
