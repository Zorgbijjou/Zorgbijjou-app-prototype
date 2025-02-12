import 'package:core/core.dart';
import 'package:core/mocks/mock_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zorg_bij_jou/routing/analytics_observer.dart';

class MockRoute extends Mock implements PageRoute {}

void main() {
  group('AnalyticsObserver', () {
    late AnalyticsObserver analyticsObserver;
    late MockRoute mockRoute;
    late MockRoute mockPreviousRoute;
    late ZbjLogger mockLogger;

    setUp(() {
      analyticsObserver = AnalyticsObserver();
      mockRoute = MockRoute();
      mockPreviousRoute = MockRoute();

      mockLogger = MockLogger();
      getIt.registerSingleton<ZbjLogger>(mockLogger);
    });

    tearDown(() {
      getIt.reset();
    });

    test('can be instantiated', () {
      expect(analyticsObserver, isNotNull);
    });

    test('logs page view on didPush when current', () async {
      var dummyData = {'test': 'test'} as Map<String, Object>;

      when(() => mockRoute.settings).thenReturn(RouteSettings(
        name: 'testRoute',
        arguments: dummyData,
      ));

      when(() => mockRoute.isCurrent).thenReturn(true);

      analyticsObserver.didPush(mockRoute, null);

      await Future.delayed(Duration.zero);

      verify(() => mockLogger.pageview('testRoute', dummyData, any()))
          .called(1);
    });

    test('logs page view on didPush when not current', () async {
      var dummyData = {'test': 'test'} as Map<String, Object>;

      when(() => mockRoute.settings).thenReturn(RouteSettings(
        name: 'testRoute',
        arguments: dummyData,
      ));

      when(() => mockRoute.isCurrent).thenReturn(false);

      analyticsObserver.didPush(mockRoute, null);

      await Future.delayed(Duration.zero);

      verifyNever(() => mockLogger.pageview(any(), any(), any()));
    });

    test('logs page view on didReplace', () async {
      var dummyData = {'test': 'test'} as Map<String, Object>;

      when(() => mockRoute.settings).thenReturn(RouteSettings(
        name: 'testRoute',
        arguments: dummyData,
      ));

      analyticsObserver.didReplace(newRoute: mockRoute, oldRoute: null);

      await Future.delayed(Duration.zero);

      verify(() => mockLogger.pageview('testRoute', dummyData, any()))
          .called(1);
    });

    test('logs page view on didPop for previous page', () async {
      var dummyData = {'test': 'test'} as Map<String, Object>;
      var dummyDataPrevious = {'test2': 'test2'} as Map<String, Object>;

      when(() => mockRoute.settings).thenReturn(RouteSettings(
        name: 'testRoute',
        arguments: dummyData,
      ));

      when(() => mockPreviousRoute.settings).thenReturn(RouteSettings(
        name: 'testPreviousRoute',
        arguments: dummyDataPrevious,
      ));

      analyticsObserver.didPop(mockRoute, mockPreviousRoute);

      await Future.delayed(Duration.zero);

      verify(() => mockLogger.pageview(
          'testPreviousRoute', dummyDataPrevious, any())).called(1);
    });
  });
}
