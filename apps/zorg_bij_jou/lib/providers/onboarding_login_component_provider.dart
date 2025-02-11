import 'package:core/auth/auth_exception.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onboarding/view_models/login_view_model.dart';

final loginViewModelProvider = StateNotifierProvider.autoDispose<
    LoginViewModelStateNotifier,
    LoginViewModel>((ref) => LoginViewModelStateNotifier());

class LoginViewModelStateNotifier extends StateNotifier<LoginViewModel> {
  final Auth auth = getIt();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController loginCodeController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  LoginViewModelStateNotifier() : super(const LoginViewModel());

  Future<bool> onSubmitLogin() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    String userCode = loginCodeController.text;
    String birthDate = birthDateController.text;

    try {
      await auth.login(userCode, birthDate);
      formKey.currentState!.save();

      state = state.copyWith(error: null);

      updateUserCode(userCode);
      customEvent('Login succeeded');

      return true;
    } catch (e) {
      if (e is AuthException) {
        customEvent('Login failed: ${e.message}');
        state = state.copyWith(
          error: LoginError.authenticationError,
        );
      } else {
        customEvent('Login unexpected failed', {'error': '$e'});
        state = state.copyWith(
          error: LoginError.unexpectedError,
        );
      }
      return false;
    }
  }
}
