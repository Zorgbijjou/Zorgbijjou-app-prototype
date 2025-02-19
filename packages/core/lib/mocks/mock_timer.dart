import 'dart:async';

class MockTimer implements Timer {
  final Duration duration;
  final void Function(Timer) callback;
  bool _isActive = true;
  int _tick = 0;

  MockTimer(
      {this.duration = const Duration(seconds: 0),
      this.callback = _defaultCallback});

  static void _defaultCallback(Timer timer) {}

  MockTimer.periodic(this.duration, this.callback);

  @override
  bool get isActive => _isActive;

  @override
  void cancel() {
    _isActive = false;
  }

  @override
  int get tick => _tick;

  void trigger() {
    if (_isActive) {
      _tick++;
      callback(this);
    }
  }
}
