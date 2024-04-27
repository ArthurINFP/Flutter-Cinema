// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/common/enums/signup_status.dart';
import 'package:cinema/core/common/model/bloc_status_state.dart';

class RegisterState {
  BlocStatusState state;
  SignUpStatus? status;
  RegisterState({
    required this.state,
    this.status,
  });

  RegisterState copyWith({
    required BlocStatusState state,
    SignUpStatus? status,
  }) {
    return RegisterState(
      state: state,
      status: status ?? this.status,
    );
  }
}
