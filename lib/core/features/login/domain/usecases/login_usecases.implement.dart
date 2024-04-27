import 'package:cinema/core/common/enums/signup_status.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/login/domain/repository/login_repository.dart';
import 'package:cinema/core/features/login/domain/repository/login_repository.implement.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

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
    final userCredential = await repository.signInWithEmailnamePassword(
        email: username, password: password);
    return userCredential?.user;
  }

  @override
  User? getCurrentUserInfo() {
    return repository.getCurrentUserInfo();
  }

  @override
  Future<SignUpStatus> createUserWithEmailAndPassword(
      {required AccountEntity entity, required String password, XFile? image}) {
    return repository.createUserWithEmailAndPassword(
        entity: entity, password: password, image: image);
  }
}
