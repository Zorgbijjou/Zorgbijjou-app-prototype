import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/toc.dart';
import 'toc_data_source.dart';

class TocDataSourceImpl implements TocDataSource {
  final AssetBundle bundle;
  final String tocPath;
  Toc? _cachedToc;

  TocDataSourceImpl({
    required this.bundle,
    this.tocPath = 'assets/faq/toc.json',
  });

  @override
  Future<Toc> fetchToc() async {
    if (_cachedToc != null) {
      return _cachedToc!;
    }

    var tocJsonString = await bundle.loadString(tocPath);
    var tocJson = json.decode(tocJsonString);

    _cachedToc = Toc.fromJson(tocJson);

    return _cachedToc!;
  }

  @override
  Future<String> fetchQuestionContent(
      String questionSlug, String locale) async {
    var contentPath = 'assets/faq/$questionSlug-$locale.md';

    var content = await bundle.loadString(contentPath, cache: false);
    return content;
  }

  @override
  Future<String> fetchSubjectContent(String subjectSlug, String locale) {
    var contentPath = 'assets/faq/$subjectSlug-$locale.md';

    var content = bundle.loadString(contentPath, cache: false);
    return content;
  }
}
