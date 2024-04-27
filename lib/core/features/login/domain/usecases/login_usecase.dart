import 'package:cinema/core/common/enums/signup_status.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

abstract class LoginUsecase {
  Future<User?> signInWithUsernamePassword(
      {required String username, required String password});

  Future<User?> signInWithGoogle();
  Future<User?> signInWithFacebook();
  User? getCurrentUserInfo();
  Future<SignUpStatus> createUserWithEmailAndPassword(
      {required AccountEntity entity, required String password, XFile? image});
}
