import 'package:core/widgets/locale_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers.dart';

class MockCallback extends Mock {
  void call(Locale locale);
}

void main() {
  group('LocaleSelector', () {
    testWidgets('Should render a dropdown with available locales',
        (tester) async {
      var currentLocale = const Locale('nl');
      var allLocales = const [Locale('en'), Locale('nl')];
      var mockLocaleChangedCallback = MockCallback();

      await tester.pumpWidget(materialAppWithTokens(
          child: Material(
              child: LocaleSelector(
        locale: currentLocale,
        supportedLocales: allLocales,
        onLocaleChanged: mockLocaleChangedCallback.call,
      ))));

      var localeDropdown = find.byType(DropdownButton<Locale>);

      expect(localeDropdown, findsOneWidget);

      await tester.tap(localeDropdown);
      await tester.pumpAndSettle();

      var englishOption = find.text('EN').last;
      await tester.tap(englishOption);

      verify(() => mockLocaleChangedCallback.call(const Locale('en')))
          .called(1);
    });
  });
}
