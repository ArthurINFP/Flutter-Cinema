import 'package:cinema/core/common/enums/signup_status.dart';
import 'package:cinema/core/features/login/data/datasource/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSorceImplement extends AuthRemoteDataSource {
  @override
  Future<UserCredential?> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('Google accout not found');
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    return result;
  }

  @override
  Future<UserCredential?> signInWithEmailnamePassword(
      {required String email, required String password}) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  User? getCurrentUserInfo() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<SignUpStatus> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return SignUpStatus.success;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException $e");
      if (e.code == 'weak-password') {
        return SignUpStatus.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return SignUpStatus.emailAlreadyInUse;
      } else {
        return SignUpStatus.unknownError;
      }
    } catch (e) {
      print("Outside FirebaseAuthException $e");
      return SignUpStatus.unknownError;
    }
  }
}
