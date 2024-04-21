import 'package:cinema/core/features/account/data/model/account_firestore_model.dart';
import 'package:cinema/core/features/account/data/remote/account_firestore_datasource.dart';
import 'package:cinema/core/features/account/data/remote/account_firestore_datasource.implement.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/account/domain/repository/account_repository.dart';

class AccountReposiotryImplement extends AccountReposiotry {
  AccountFirestoreDatasource datasource = AccountFirestoreDatasourceImplement();
  @override
  Future<AccountModel?> getAccountInfo({required String uid}) {
    return datasource.getAccountInfo(uid: uid);
  }

  @override
  Future<AccountEntity?> updateAccountInfo(
      {required AccountModel newAccountModel}) {
    return datasource.updateAccountInfo(newAccountModel: newAccountModel);
  }
}
