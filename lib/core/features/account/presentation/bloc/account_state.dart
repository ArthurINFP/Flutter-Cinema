// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cinema/core/features/account/domain/entity/account_entity.dart';

abstract class AccountState {}

class InitAccountState extends AccountState {}

class LoadingAccountState extends AccountState {}

class SuccessAccountState extends AccountState {
  AccountEntity entity;
  String? message;
  SuccessAccountState({
    required this.entity,
    this.message,
  });
}

class LoadingUpdateAccountState extends AccountState {
  AccountEntity newEntity;
  LoadingUpdateAccountState({
    required this.newEntity,
  });
}

class UpdateSuccessfullyAcountState extends AccountState {
  AccountEntity newEntity;
  UpdateSuccessfullyAcountState({
    required this.newEntity,
  });
}

class FailedUpdateAccountState extends AccountState {
  AccountEntity oldEntity;
  String message;

  FailedUpdateAccountState({
    required this.oldEntity,
    required this.message,
  });
}

class FailedAccountState extends AccountState {
  String message;
  FailedAccountState({
    required this.message,
  });
}
