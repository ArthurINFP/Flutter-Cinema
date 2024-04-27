import 'package:cinema/core/features/account/data/model/account_firestore_model.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/account/domain/repository/account_repository.dart';
import 'package:cinema/core/features/account/domain/repository/account_repository.implement.dart';
import 'package:cinema/core/features/account/domain/usecases/account_usecases.dart';
import 'package:cinema/core/features/login/domain/repository/login_repository.dart';
import 'package:cinema/core/features/login/domain/repository/login_repository.implement.dart';
import 'package:cinema/core/features/login/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AccountUsecasesImplement extends AccountUsecases {
  AccountReposiotry reposiotry = AccountReposiotryImplement();
  LoginRepository loginRepository = LoginRepositoryImplement();
  @override
  Future<AccountEntity?> getAccountInfo() async {
    final result = await reposiotry.getAccountInfo();
    final user = await loginRepository.getCurrentUserInfo();
    return (user != null) ? result?.toEntity(uid: user.uid) : null;
  }

  @override
  Future<AccountEntity?> updateAccountInfo(
      {required AccountEntity newAccountEntity}) {
    return reposiotry.updateAccountInfo(
        newAccountModel: AccountModel.fromEntity(newAccountEntity));
  }

  @override
  Future<String?> updateAvatar({required XFile image}) {
    return reposiotry.updateAvatar(image: image);
  }
}
