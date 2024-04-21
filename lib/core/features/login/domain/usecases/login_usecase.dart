import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginUsecase {
  Future<User?> signInWithUsernamePassword(
      {required String username, required String password});

  Future<User?> signInWithGoogle();
  Future<User?> signInWithFacebook();
  User? getCurrentUserInfo();
}
