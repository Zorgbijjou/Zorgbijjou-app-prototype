import 'package:core/l10n/core_localizations.dart';
import 'package:core/widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onboarding/view_models/onboarding_view_model.dart';
import 'package:onboarding/widgets/login.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:zorg_bij_jou/providers/onboarding_login_component_provider.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

class OnboardingLoginComponent extends OnboardingComponent {
  final Function onContinue;

  OnboardingLoginComponent({required this.onContinue, Key? key})
      : super(globalKey: GlobalKey());

  @override
  OnboardingComponentState<OnboardingLoginComponent> createState() =>
      _OnboardingLoginPageState();
}

class _OnboardingLoginPageState
    extends OnboardingComponentState<OnboardingLoginComponent> {
  _onShowLoginInformationClicked(BuildContext context) {
    context.go('/$onboardingRoute/$loginInformationRoute');
  }

  _onSubmitLogin() async {
    var isSuccess =
        await ref.read(loginViewModelProvider.notifier).onSubmitLogin();

    if (!isSuccess) {
      return;
    }

    widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(loginViewModelProvider);
    var provider = ref.read(loginViewModelProvider.notifier);

    return Login(
      viewModel: viewModel,
      formKey: provider.formKey,
      loginCodeController: provider.loginCodeController,
      birthDateController: provider.birthDateController,
      onSubmitLogin: _onSubmitLogin,
      onShowLoginInformationClicked: _onShowLoginInformationClicked,
    );
  }

  @override
  Widget buildActionButton(BuildContext context) {
    return ZbjIconButton.brand(
      tooltip: AppLocalizations.of(context)!.nextButtonAccessibilityLabel,
      icon: const Icon(CustomIcons.arrow_right),
      onPressed: _onSubmitLogin,
    );
  }
}
