import 'package:cinema/core/features/login/data/datasource/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<UserCredential?> signInWithUsernamePassword(
      {required String username, required String password}) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: username, password: password);
    return userCredential;
  }
}
