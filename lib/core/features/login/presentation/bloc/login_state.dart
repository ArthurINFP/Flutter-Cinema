// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class SuccessfulLoginState extends LoginState {
  String? message;
}

class FailedLoginState extends LoginState {
  String? message;
  bool? isFailedAtPassword;
  bool? isFailedAtUsername;
  FailedLoginState({
    this.message,
    this.isFailedAtPassword,
    this.isFailedAtUsername,
  });
}

class FailedThirdPartyLoginState extends LoginState {
  String message;
  FailedThirdPartyLoginState({
    required this.message,
  });
}

class LoadingLoginState extends LoginState {}
