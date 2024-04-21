import 'dart:async';

import 'package:cinema/core/features/account/domain/usecases/account_usecases.dart';
import 'package:cinema/core/features/account/domain/usecases/account_usecases.implement.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_event.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_state.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecase.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecases.implement.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(InitAccountState()) {
    on<GetAccountInfoEvent>(_onGetAccountInfoEvent);
    on<UpdateAccountInfoEvent>(_onUpdateAccountInfoEvent);
  }

  final LoginUsecase _loginUsecase = LoginUsecaseImplement();
  final AccountUsecases _accountUsecases = AccountUsecasesImplement();

  FutureOr<void> _onGetAccountInfoEvent(
      GetAccountInfoEvent event, Emitter<AccountState> emit) async {
    emit(LoadingAccountState());

    try {
      final currentUser = _loginUsecase.getCurrentUserInfo();
      if (currentUser?.uid != null) {
        final accountEntity =
            await _accountUsecases.getAccountInfo(uid: currentUser!.uid);
        print(accountEntity?.displayName ?? "null");
        print(accountEntity?.dateOfBirth ?? "null");
        print(accountEntity?.city ?? "null");
        print(accountEntity?.email ?? "null");
        print(accountEntity?.gender ?? "null");
        print(accountEntity?.phoneNumber ?? "null");
        emit(accountEntity != null
            ? SuccessAccountState(entity: accountEntity)
            : FailedAccountState(message: "Can't find user"));
      } else {
        emit(FailedAccountState(message: "Can't find user"));
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  FutureOr<void> _onUpdateAccountInfoEvent(
      UpdateAccountInfoEvent event, Emitter<AccountState> emit) async {
    emit(LoadingUpdateAccountState(newEntity: event.newEntity));

    try {
      final currentUser = _loginUsecase.getCurrentUserInfo();
      if (currentUser?.uid != null) {
        final updatedEntity = await _accountUsecases.updateAccountInfo(
            newAccountEntity: event.newEntity);
        print(updatedEntity?.displayName ?? "null");
        print(updatedEntity?.dateOfBirth ?? "null");
        print(updatedEntity?.city ?? "null");
        print(updatedEntity?.email ?? "null");
        print(updatedEntity?.gender ?? "null");
        print(updatedEntity?.phoneNumber ?? "null");
        emit(updatedEntity != null
            ? SuccessAccountState(
                entity: updatedEntity, message: "Updated Successfully")
            : FailedUpdateAccountState(
                oldEntity: event.oldEntity, message: "Can't find uid"));
      } else {
        emit(FailedUpdateAccountState(
            oldEntity: event.oldEntity, message: "Failed to update"));
      }
    } catch (e) {
      FailedUpdateAccountState(
          oldEntity: event.oldEntity, message: "Something went wrong");
    }
    return null;
  }
}
