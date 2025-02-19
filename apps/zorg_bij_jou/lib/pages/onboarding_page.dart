import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding/onboarding.dart';

import '../providers/onboarding_page_provider.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) {
        return;
      }

      ref.read(onboardingViewModelProvider.notifier).initialize();
    });
    ref.read(onboardingViewModelProvider.notifier).initializeWithContent();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(onboardingViewModelProvider);

    return Onboarding(
      viewModel: viewModel,
      translationRepository: getIt(),
    );
  }
}
