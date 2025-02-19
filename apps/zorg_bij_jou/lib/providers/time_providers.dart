import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerFactoryProvider =
    Provider<Timer Function(Duration, void Function(Timer))>((ref) {
  return (duration, callback) => Timer.periodic(duration, callback);
});
