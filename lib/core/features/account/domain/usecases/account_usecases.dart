import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class AccountUsecases {
  Future<AccountEntity?> getAccountInfo();
  Future<AccountEntity?> updateAccountInfo(
      {required AccountEntity newAccountEntity});
  Future<String?> updateAvatar({required XFile image});
}
