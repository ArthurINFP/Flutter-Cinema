import 'package:cinema/core/features/account/domain/entity/account_entity.dart';

abstract class AccountUsecases {
  Future<AccountEntity?> getAccountInfo({required String uid});
  Future<AccountEntity?> updateAccountInfo(
      {required AccountEntity newAccountEntity});
}
