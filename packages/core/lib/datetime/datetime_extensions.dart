import 'package:clock/clock.dart';

extension DateTimeExtensions on DateTime {
  bool get isToday {
    var now = clock.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    var now = clock.now();
    var yesterday = now.subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }
}
