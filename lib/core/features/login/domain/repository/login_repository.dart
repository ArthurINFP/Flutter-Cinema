import 'package:cinema/core/common/enums/signup_status.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

abstract class LoginRepository {
  Future<UserCredential?> signInWithEmailnamePassword(
      {required String email, required String password});

  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signInWithFacebook();
  User? getCurrentUserInfo();
  Future<SignUpStatus> createUserWithEmailAndPassword(
      {required AccountEntity entity, required String password, XFile? image});
}
