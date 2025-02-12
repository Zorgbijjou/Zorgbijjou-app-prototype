import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_view_model.freezed.dart';

@freezed
class OnboardingViewModel with _$OnboardingViewModel {
  const factory OnboardingViewModel({
    @Default(null) Locale? locale,
    @Default(false) bool isLoading,
    @Default(null) String? termsAndConditionsContent,
    @Default(null) String? loginInformationContent,
    String? error,
    required PageController pageController,
    @Default([]) List<OnboardingComponent> components,
    @Default(0) int currentPage,
  }) = _OnboardingViewModel;

  get isBackButtonActive => currentPage >= 3;

  get componentForCurrentPage => components[currentPage];

  const OnboardingViewModel._();
}

/// 1) An abstract, base onboarding widget
abstract class OnboardingComponent extends ConsumerStatefulWidget {
  final GlobalKey<OnboardingComponentState> globalKey;

  // set globalKeyAs Key
  const OnboardingComponent({required this.globalKey}) : super(key: globalKey);
}

/// 2) Its state knows how to build the overall layout:
///    - main content (provided by subclass)
///    - action button (provided by subclass)
abstract class OnboardingComponentState<T extends OnboardingComponent>
    extends ConsumerState<T> {
  /// Each onboarding screen provides its action button:
  /// (or return SizedBox.shrink() if you want no button)
  Widget buildActionButton(BuildContext context);
}
