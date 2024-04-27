import 'package:cinema/core/common/enums/signup_status.dart';
import 'package:cinema/core/features/account/data/model/account_firestore_model.dart';
import 'package:cinema/core/features/account/data/remote/account_firestore_datasource.dart';
import 'package:cinema/core/features/account/data/remote/account_firestore_datasource.implement.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/login/data/datasource/auth_remote_datasource.dart';
import 'package:cinema/core/features/login/data/datasource/auth_remote_datasource.implement.dart';
import 'package:cinema/core/features/login/domain/repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class LoginRepositoryImplement extends LoginRepository {
  AuthRemoteDataSource authDataSource = AuthRemoteDataSorceImplement();
  AccountFirestoreDatasource accountFirestoreDatasource =
      AccountFirestoreDatasourceImplement();
  @override
  Future<UserCredential?> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserCredential?> signInWithGoogle() {
    return authDataSource.signInWithGoogle();
  }

  @override
  Future<UserCredential?> signInWithEmailnamePassword(
      {required String email, required String password}) {
    return authDataSource.signInWithEmailnamePassword(
        email: email, password: password);
  }

  @override
  User? getCurrentUserInfo() {
    return authDataSource.getCurrentUserInfo();
  }

  @override
  Future<SignUpStatus> createUserWithEmailAndPassword(
      {required AccountEntity entity,
      required String password,
      XFile? image}) async {
    final status = await authDataSource.createUserWithEmailAndPassword(
        email: entity.email!, password: password);
    if (status == SignUpStatus.success) {
      await authDataSource.signInWithEmailnamePassword(
          email: entity.email!, password: password);

      if (image != null) {
        final uid = getCurrentUserInfo();
        entity.uid = uid!.uid;
        final url = await accountFirestoreDatasource.updateAvatar(image: image);
        entity.photoURL = url;
      }
      await accountFirestoreDatasource.updateAccountInfo(
          newAccountModel: AccountModel.fromEntity(entity));
      await FirebaseAuth.instance.signOut();
      return status;
    } else {
      return status;
    }
  }
}
