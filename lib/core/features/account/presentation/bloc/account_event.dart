// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';

abstract class AccountEvent {}

class GetAccountInfoEvent extends AccountEvent {}

class UpdateAccountInfoEvent extends AccountEvent {
  AccountEntity oldEntity;
  AccountEntity newEntity;
  UpdateAccountInfoEvent({
    required this.oldEntity,
    required this.newEntity,
  });
}
