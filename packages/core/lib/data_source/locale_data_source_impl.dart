import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter/services.dart';

import 'locale_data_source.dart';

class LocaleDataSourceImpl implements LocaleDataSource {
  final AssetBundle bundle;
  final Map<String, Map<String, dynamic>> _localeCache = {};

  LocaleDataSourceImpl({
    required this.bundle,
  });

  Future<void> initializeLocales(List<String> locales) async {
    for (var locale in locales) {
      late dynamic localeJson;
      try {
        var localeJsonString =
            await bundle.loadString('packages/core/l10n/core_$locale.arb');
        localeJson = json.decode(localeJsonString);
      } catch (e) {
        severe('initialization', 'Could not initialize locales: $e');
      }

      assert(localeJson != null);
      assert(localeJson is Map<String, dynamic>);
      assert(localeJson.keys.length > 0);

      _localeCache[locale] = localeJson;
    }
  }

  @override
  Map<String, dynamic> fetchLocale(String locale) {
    if (!_localeCache.containsKey(locale)) {
      return {};
    }

    return _localeCache[locale]!;
  }
}
