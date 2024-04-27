import 'package:cinema/core/features/account/data/model/account_firestore_model.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class AccountReposiotry {
  Future<AccountModel?> getAccountInfo();
  Future<AccountEntity?> updateAccountInfo(
      {required AccountModel newAccountModel});
  Future<String?> updateAvatar({required XFile image});
}
