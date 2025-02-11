import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding/onboarding.dart';

import '../providers/onboarding_page_provider.dart';

class TermsAndConditionsPage extends ConsumerStatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  ConsumerState<TermsAndConditionsPage> createState() =>
      _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState
    extends ConsumerState<TermsAndConditionsPage> {
  @override
  void initState() {
    super.initState();

    ref.read(onboardingViewModelProvider.notifier).initializeWithContent();
  }

  _onBackTermsAndConditionsClicked(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(onboardingViewModelProvider);

    return TermsAndConditions(
      content: viewModel.termsAndConditionsContent,
      onBackClicked: _onBackTermsAndConditionsClicked,
    );
  }
}
