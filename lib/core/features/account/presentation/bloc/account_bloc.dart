import 'dart:async';

import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/account/domain/usecases/account_usecases.dart';
import 'package:cinema/core/features/account/domain/usecases/account_usecases.implement.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_event.dart';
import 'package:cinema/core/features/account/presentation/bloc/account_state.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecase.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecases.implement.dart';
import 'package:cinema/core/features/ticket/domain/usecases/ticket_usecases.dart';
import 'package:cinema/core/features/ticket/domain/usecases/ticket_usecases.implement.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountState(status: BlocStatusState.init)) {
    on<GetAccountInfoEvent>(_onGetAccountInfoEvent);
    on<UpdateAccountInfoEvent>(_onUpdateAccountInfoEvent);
    on<DeleteTicketAccountEvent>(_onDeleteTicketAccountEvent);
    on<UpdateAccountAvatarEvent>(_UpdateAccountAvatarEvent);
  }

  final LoginUsecase _loginUsecase = LoginUsecaseImplement();
  final AccountUsecases _accountUsecases = AccountUsecasesImplement();
  final TicketUsecases _ticketUsecases = TicketUsecasesImplement();

  FutureOr<void> _onGetAccountInfoEvent(
      GetAccountInfoEvent event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: BlocStatusState.loading));

    try {
      final currentUser = _loginUsecase.getCurrentUserInfo();
      if (currentUser?.uid != null) {
        final accountEntity = await _accountUsecases.getAccountInfo();
        final tickets =
            await _ticketUsecases.queryTickets(userId: currentUser!.uid);
        printAccountEntity(accountEntity);

        if (accountEntity == null) {
          emit(state.copyWith(
              status: BlocStatusState.failed,
              message: "Fail to get user's info"));
        }
        if (tickets == null) {
          emit(state.copyWith(
              status: BlocStatusState.failed,
              message: "Fail to get user ticket"));
        }
        emit(state.copyWith(
          status: BlocStatusState.success,
          currentEntity: accountEntity,
          ticketEntities: tickets,
          newEntity: accountEntity!.copyWith(),
        ));
      } else {
        emit(state.copyWith(
            status: BlocStatusState.failed, message: "Invalid user ID"));
      }
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatusState.failed, message: "Unexpected error"));
      throw Exception(e);
    }
  }

  FutureOr<void> _onUpdateAccountInfoEvent(
      UpdateAccountInfoEvent event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: BlocStatusState.loading));

    try {
      final currentUser = _loginUsecase.getCurrentUserInfo();
      if (currentUser?.uid != null) {
        final updatedEntity = await _accountUsecases.updateAccountInfo(
            newAccountEntity: event.newEntity);
        printAccountEntity(updatedEntity);
        emit(updatedEntity != null
            ? state.copyWith(
                status: BlocStatusState.success,
                currentEntity: updatedEntity,
                newEntity: updatedEntity.copyWith(),
                message: "Updated Successfully")
            : state.copyWith(
                status: BlocStatusState.failed,
                message: "Failed to update user info"));
      } else {
        state.copyWith(
            status: BlocStatusState.failed, message: "Can't find uid");
      }
    } catch (e) {
      state.copyWith(
          status: BlocStatusState.failed, message: "Unexpected error");
    }
  }

  FutureOr<void> _onDeleteTicketAccountEvent(
      DeleteTicketAccountEvent event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: BlocStatusState.loading));
    print("Bloc running");
    try {
      final result = await _ticketUsecases.deleteTicket(event.ticketId);
      if (result) {
        final tickets = state.ticketEntities;
        print(tickets);
        tickets!.remove(event.entity);
        print(tickets);
        emit(state.copyWith(
            status: BlocStatusState.success,
            message: "Delete ticket Successfully",
            ticketEntities: tickets));
      } else {
        emit(state.copyWith(
            status: BlocStatusState.failed, message: "Delete ticket Failed"));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          status: BlocStatusState.failed, message: "Delete ticket Failed"));
    }
  }

  FutureOr<void> _UpdateAccountAvatarEvent(
      UpdateAccountAvatarEvent event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: BlocStatusState.loading));
    try {
      final url = await _accountUsecases.updateAvatar(image: event.image);
      if (url != null) {
        if (state.currentEntity != null) {
          final user = state.currentEntity;
          user!.photoURL = url;
          final updatedEntity =
              await _accountUsecases.updateAccountInfo(newAccountEntity: user);
          printAccountEntity(updatedEntity);
          emit(updatedEntity != null
              ? state.copyWith(
                  status: BlocStatusState.success,
                  currentEntity: updatedEntity,
                  newEntity: updatedEntity.copyWith(),
                  message: "Updated Successfully")
              : state.copyWith(
                  status: BlocStatusState.failed,
                  message: "Failed to update user info"));
          emit(state.copyWith(status: BlocStatusState.success));
        } else {
          emit(state.copyWith(
              status: BlocStatusState.failed, message: "Cant find account"));
        }
      } else {
        emit(state.copyWith(
            status: BlocStatusState.failed,
            message: "Failed to update avatar "));
      }
    } catch (e) {}
  }

  void printAccountEntity(AccountEntity? updatedEntity) {
    print(updatedEntity?.displayName ?? "null");
    print(updatedEntity?.dateOfBirth ?? "null");
    print(updatedEntity?.city ?? "null");
    print(updatedEntity?.email ?? "null");
    print(updatedEntity?.gender ?? "null");
    print(updatedEntity?.phoneNumber ?? "null");
  }
}
