import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding/onboarding.dart';

import '../providers/onboarding_page_provider.dart';

class LoginInformationPage extends ConsumerStatefulWidget {
  const LoginInformationPage({super.key});

  @override
  ConsumerState<LoginInformationPage> createState() =>
      _LoginInformationPageState();
}

class _LoginInformationPageState extends ConsumerState<LoginInformationPage> {
  @override
  void initState() {
    super.initState();

    ref.read(onboardingViewModelProvider.notifier).initializeWithContent();
  }

  _onBackLoginInformationClicked(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(onboardingViewModelProvider);

    return LoginInformation(
      content: viewModel.loginInformationContent,
      onBackClicked: _onBackLoginInformationClicked,
    );
  }
}
