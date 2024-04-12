import 'package:cinema/core/features/login/data/datasource/auth_remote_datasource.dart';
import 'package:cinema/core/features/login/data/datasource/auth_remote_datasource.implement.dart';
import 'package:cinema/core/features/login/domain/repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepositoryImplement extends LoginRepository {
  AuthRemoteDataSource dataSource = AuthRemoteDataSorceImplement();
  @override
  Future<UserCredential?> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserCredential?> signInWithGoogle() {
    return dataSource.signInWithGoogle();
  }

  @override
  Future<UserCredential?> signInWithUsernamePassword(
      {required String username, required String password}) {
    return dataSource.signInWithUsernamePassword(
        username: username, password: password);
  }
}
