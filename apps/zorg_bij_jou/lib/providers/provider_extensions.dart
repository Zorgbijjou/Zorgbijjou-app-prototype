import 'package:flutter_riverpod/flutter_riverpod.dart';

extension ProviderRefExtension on Ref {
  void readAndListen<T, Notifier extends StateNotifier<T>>(
      StateNotifierProvider<Notifier, T> provider, void Function(T) setter) {
    // Read the initial value and set it
    T initialValue = read(provider);
    setter(initialValue);

    // Listen for changes and update accordingly
    listen<T>(provider, (previous, next) {
      setter(next);
    });
  }

  void readAndListenStateProvider<T>(
      StateProvider<T> provider, void Function(T) setter) {
    // Read the initial value and set it
    T initialValue = read(provider);
    setter(initialValue);

    // Listen for changes and update accordingly
    listen<T>(provider, (previous, next) {
      setter(next);
    });
  }

  void readAndListenProvider<T>(Provider<T> provider, void Function(T) setter) {
    // Read the initial value and set it
    T initialValue = read(provider);
    setter(initialValue);

    // Listen for changes and update accordingly
    listen<T>(provider, (previous, next) {
      setter(next);
    });
  }
}
