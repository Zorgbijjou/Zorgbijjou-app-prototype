import 'package:mocktail/mocktail.dart';

import '../data_source/local_storage.dart';

class MockLocalStorage extends Mock implements LocalStorage {
  @override
  bool loadDevMode() {
    return true;
  }
}
