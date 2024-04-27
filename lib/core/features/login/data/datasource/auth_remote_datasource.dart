import 'package:cinema/core/common/enums/signup_status.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential?> signInWithEmailnamePassword(
      {required String email, required String password});

  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signInWithFacebook();
  User? getCurrentUserInfo();
  Future<SignUpStatus> createUserWithEmailAndPassword(
      {required String email, required String password});
}
