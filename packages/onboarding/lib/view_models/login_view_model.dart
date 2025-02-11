import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_view_model.freezed.dart';

@freezed
class LoginViewModel with _$LoginViewModel {
  const factory LoginViewModel({
    LoginError? error,
  }) = _LoginViewModel;

  const LoginViewModel._();
}

enum LoginError {
  authenticationError,
  unexpectedError,
}
