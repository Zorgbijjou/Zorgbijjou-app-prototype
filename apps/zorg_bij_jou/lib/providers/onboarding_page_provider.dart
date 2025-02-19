import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:onboarding/onboarding.dart';
import 'package:onboarding/view_models/onboarding_view_model.dart';
import 'package:zorg_bij_jou/pages/onboarding_login_component.dart';
import 'package:zorg_bij_jou/pages/onboarding_validate_information_component.dart';
import 'package:zorg_bij_jou/providers/locale_provider.dart';
import 'package:zorg_bij_jou/providers/provider_extensions.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

final onboardingViewModelProvider = StateNotifierProvider.autoDispose<
    OnboardingViewModelStateNotifier,
    OnboardingViewModel>((ref) => OnboardingViewModelStateNotifier(ref));

class OnboardingViewModelStateNotifier
    extends StateNotifier<OnboardingViewModel> {
  final Ref _ref;
  final OnboardingDataSource onboardingDataSource = getIt();
  final LocalStorage onboardingStorage = getIt();
  final Auth auth = getIt();
  final formKey = GlobalKey<FormState>();
  final loginCodeController = TextEditingController();
  final birthDateController = TextEditingController();

  OnboardingViewModelStateNotifier(this._ref)
      : super(OnboardingViewModel(
          pageController: PageController(),
        )) {
    _ref.readAndListenStateProvider(localeProvider, updateLocale);
  }

  void initialize() {
    state = state.copyWith(
      components: buildComponents(),
    );

    state.pageController.addListener(() {
      var page = state.pageController.page!.round();

      state = state.copyWith(
        currentPage: page,
      );
    });
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }

  List<OnboardingComponent> buildComponents() {
    return [
      TermsAndConditionsSummary(
        onTermsAndConditionsClicked: _onShowAllTermsAndConditionsClicked,
        onContinue: onNext,
      ),
      OnboardingLoginComponent(
        onContinue: onNext,
      ),
      OnboardingValidateInformationComponent(
        onContinue: onNext,
      ),
      MultipleAppsIntroduction(
        onContinue: onNext,
      ),
      MultipleAppsZorgBijJou(
        onContinue: onNext,
      ),
      MultipleAppsHomeMeasurement(
        onContinue: onNext,
      ),
      GettingStarted(
        onContinue: _onFinishOnboardingClicked,
      ),
    ];
  }

  _onShowAllTermsAndConditionsClicked(BuildContext context) {
    context.go('/$onboardingRoute/$termsAndConditionsRoute');
  }

  _onFinishOnboardingClicked(BuildContext context) {
    customEvent('Onboarding Finished');
    onboardingStorage.storeFinishedOnboarding();
    context.go('/$supportHome');
  }

  void updateLocale(Locale locale) {
    state = state.copyWith(
      locale: locale,
    );
  }

  Future initializeWithContent() async {
    var termsAndConditionsContentFuture = onboardingDataSource
        .fetchTermsAndConditionsContent(state.locale?.languageCode ?? '');
    var loginInformationContentFuture = onboardingDataSource
        .fetchLoginInformationContent(state.locale?.languageCode ?? '');
    var (termsAndConditionsContent, loginInformationContent) = await (
      termsAndConditionsContentFuture,
      loginInformationContentFuture
    ).wait;

    state = state.copyWith(
      termsAndConditionsContent: termsAndConditionsContent,
      loginInformationContent: loginInformationContent,
    );
  }

  onNext() {
    state.pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  onPrevious() {
    state.pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
