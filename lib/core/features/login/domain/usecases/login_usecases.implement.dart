import 'package:cinema/core/features/login/domain/repository/login_repository.dart';
import 'package:cinema/core/features/login/domain/repository/login_repository.implement.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUsecaseImplement extends LoginUsecase {
  LoginRepository repository = LoginRepositoryImplement();
  @override
  Future<User?> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User?> signInWithGoogle() async {
    final userCredential = await repository.signInWithGoogle();
    return userCredential?.user;
  }

  @override
  Future<User?> signInWithUsernamePassword(
      {required String username, required String password}) async {
    final userCredential = await repository.signInWithUsernamePassword(
        username: username, password: password);
    return userCredential?.user;
  }

  @override
  User? getCurrentUserInfo() {
    return repository.getCurrentUserInfo();
  }
}
