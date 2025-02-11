import 'dart:io';

import 'package:azure_application_insights/azure_application_insights.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

// ignore: constant_identifier_names
const APP_INSIGHTS_INSTRUMENTATION_KEY = 'APP_INSIGHTS_INSTRUMENTATION_KEY';

// ignore: constant_identifier_names
const APP_INSIGHTS_SESSION_ID = 'APP_INSIGHTS_SESSION_ID';

class AppInsightsLogger implements ZbjLogger {
  final String instrumentationKey;
  final String sessionId;
  String userCode;
  late final Client? client;
  late final TelemetryClient? telemetryClient;
  final void Function(Object) printer;

  AppInsightsLogger({
    required this.userCode,
    required this.instrumentationKey,
    required this.sessionId,
    this.printer = print,
  });

  String getDeviceModel() {
    if (kIsWeb) {
      return '';
    }

    var display = PlatformDispatcher.instance.views.first.display;
    return display.size.shortestSide / display.devicePixelRatio < 600
        ? 'phone'
        : 'tablet';
  }

  logToConsole(String level, String message) {
    printer(
        '${DateTime.now().toUtc().toIso8601String()} [$level] [AppInsightsLogger] $message');
  }

  @override
  updateUserCode(String code) {
    userCode = code;
    if (telemetryClient != null) {
      telemetryClient!.context.user.id = userCode;
    }
  }

  @override
  Future<ZbjLogger> initialize() {
    if (instrumentationKey.isEmpty) {
      telemetryClient = null;
      client = null;

      logToConsole('WARN',
          'Application insights instrumentation key not provided, telemetry will not be recorded');

      return Future.value(this);
    }

    if (sessionId.isEmpty) {
      logToConsole('WARN', 'Session id is empty');
    }

    client = Client();
    telemetryClient = TelemetryClient(
        processor: BufferedProcessor(
      next: TransmissionProcessor(
        instrumentationKey: instrumentationKey,
        httpClient: client!,
        timeout: const Duration(seconds: 10),
      ),
    ));
    telemetryClient!.context
      ..applicationVersion = 'dev'
      ..user.id = userCode
      ..session.sessionId = sessionId
      ..device.model = getDeviceModel()
      ..device.type = !kIsWeb ? Platform.operatingSystem : 'web';

    logToConsole('FINE', 'Application Insights logger initialized');

    return Future.value(this);
  }

  @override
  void customEvent(String eventname, [Map<String, Object> data = const {}]) {
    if (telemetryClient == null) return;

    telemetryClient!.trackEvent(name: eventname, additionalProperties: data);
  }

  @override
  void pageview(String pagename,
      [Map<String, Object> data = const {}, String? uri]) {
    if (telemetryClient == null) return;

    telemetryClient!
        .trackPageView(name: pagename, url: uri, additionalProperties: data);
  }

  @override
  void fine(String message) {
    // Do not trace fine stuff in App Insights
  }

  @override
  void info(String message) {
    if (telemetryClient == null) return;

    telemetryClient!
        .trackTrace(severity: Severity.information, message: message);
  }

  @override
  void severe(String message) {
    if (telemetryClient == null) return;

    telemetryClient!.trackError(severity: Severity.critical, error: message);
  }

  @override
  void warning(String message) {
    if (telemetryClient == null) return;

    telemetryClient!.trackTrace(severity: Severity.warning, message: message);
  }
}
