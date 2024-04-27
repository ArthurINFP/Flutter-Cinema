import 'dart:async';

import 'package:cinema/core/features/login/domain/usecases/login_usecase.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecases.implement.dart';
import 'package:cinema/core/features/login/presentation/bloc/login_bloc/login_event.dart';
import 'package:cinema/core/features/login/presentation/bloc/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState()) {
    on<UsernamePasswordLoginEvent>(_onUserNamePasswordEvent);
    on<ThirdPartyLoginEvent>(_onThirdPartyLoginEvent);
  }
  final LoginUsecase _usecase = LoginUsecaseImplement();

  FutureOr<void> _onUserNamePasswordEvent(
      UsernamePasswordLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoadingLoginState());

    print('This is login Bloc');
    print(event.username);
    print(event.password);

    try {
      final user = await _usecase.signInWithUsernamePassword(
          username: event.username.trim(), password: event.password.trim());

      if (user != null) {
        emit(SuccessfulLoginState());
      } else {
        emit(FailedLoginState(message: 'Unknown Error!'));
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  FutureOr<void> _onThirdPartyLoginEvent(
      ThirdPartyLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoadingLoginState());
    if (event.isGoogle) {
      try {
        final user = await _usecase.signInWithGoogle();
        if (user == null) {
          emit(FailedThirdPartyLoginState(message: "User not found!"));
        } else {
          emit(SuccessfulLoginState());
        }
      } catch (e) {
        emit(FailedThirdPartyLoginState(message: e.toString()));
      }
    }
  }
}
