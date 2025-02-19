import 'dart:ui';

import 'package:faq/faq.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_view_model.freezed.dart';

@freezed
class HomeViewModel with _$HomeViewModel {
  const factory HomeViewModel({
    @Default(null) Locale? locale,
    @Default(false) bool isLoading,
    @Default(null) List<Question>? questions,
    @Default(null) List<Subject>? subjects,
    String? error,
  }) = _HomeViewModel;

  List<Subject> getOrderedSubjects() {
    return [...subjects ?? []]..sort((a, b) => a.order.compareTo(b.order));
  }

  List<Question> getOrderedQuestions() {
    return [...questions ?? []]..sort((a, b) => a.order!.compareTo(b.order!));
  }

  const HomeViewModel._();
}
