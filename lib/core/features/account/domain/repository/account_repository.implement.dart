import 'package:cinema/core/features/account/data/model/account_firestore_model.dart';
import 'package:cinema/core/features/account/data/remote/account_firestore_datasource.dart';
import 'package:cinema/core/features/account/data/remote/account_firestore_datasource.implement.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/account/domain/repository/account_repository.dart';
import 'package:image_picker/image_picker.dart';

class AccountReposiotryImplement extends AccountReposiotry {
  AccountFirestoreDatasource datasource = AccountFirestoreDatasourceImplement();
  @override
  Future<AccountModel?> getAccountInfo() {
    return datasource.getAccountInfo();
  }

  @override
  Future<AccountEntity?> updateAccountInfo(
      {required AccountModel newAccountModel}) {
    return datasource.updateAccountInfo(newAccountModel: newAccountModel);
  }

  @override
  Future<String?> updateAvatar({required XFile image}) {
    return datasource.updateAvatar(image: image);
  }
}
