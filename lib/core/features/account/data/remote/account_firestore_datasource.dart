import 'package:cinema/core/features/account/data/model/account_firestore_model.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';

abstract class AccountFirestoreDatasource {
  Future<AccountModel?> getAccountInfo({required String uid});
  Future<AccountEntity?> updateAccountInfo(
      {required AccountModel newAccountModel});
}
