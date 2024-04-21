import 'package:cinema/core/features/account/data/model/account_firestore_model.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/account/domain/repository/account_repository.dart';
import 'package:cinema/core/features/account/domain/repository/account_repository.implement.dart';
import 'package:cinema/core/features/account/domain/usecases/account_usecases.dart';

class AccountUsecasesImplement extends AccountUsecases {
  AccountReposiotry reposiotry = AccountReposiotryImplement();
  @override
  Future<AccountEntity?> getAccountInfo({required String uid}) async {
    final result = await reposiotry.getAccountInfo(uid: uid);
    return result?.toEntity(uid: uid);
  }

  @override
  Future<AccountEntity?> updateAccountInfo(
      {required AccountEntity newAccountEntity}) {
    return reposiotry.updateAccountInfo(
        newAccountModel: AccountModel.fromEntity(newAccountEntity));
  }
}
