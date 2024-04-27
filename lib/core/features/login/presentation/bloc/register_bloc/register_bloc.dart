import 'dart:async';

import 'package:cinema/core/common/enums/signup_status.dart';
import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecase.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecases.implement.dart';
import 'package:cinema/core/features/login/presentation/bloc/register_bloc/register_event.dart';
import 'package:cinema/core/features/login/presentation/bloc/register_bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState(state: BlocStatusState.init)) {
    on<RegisterWithEmailEvent>(_onRegisterWithEmailEvent);
  }
  final LoginUsecase _usecase = LoginUsecaseImplement();

  FutureOr<void> _onRegisterWithEmailEvent(
      RegisterWithEmailEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(state: BlocStatusState.loading));
    try {
      final result = await _usecase.createUserWithEmailAndPassword(
          entity: event.entity, password: event.password, image: event.image);
      if (result == SignUpStatus.success) {
        emit(state.copyWith(state: BlocStatusState.success, status: result));
      } else {
        emit(state.copyWith(state: BlocStatusState.failed, status: result));
      }
    } catch (e) {
      emit(state.copyWith(
          state: BlocStatusState.failed, status: SignUpStatus.unknownError));
    }
  }
}
