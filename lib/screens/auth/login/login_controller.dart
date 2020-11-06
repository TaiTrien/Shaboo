import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  TextEditingController usernameController;
  TextEditingController passwordController;
  BuildContext context;

  LoginController({this.context}) {
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User user = authResult.user;
      var googleToken = googleSignInAuthentication.accessToken;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        print('signInWithGoogle succeeded: $user');
        print('Google token: $googleToken');
        return '$user';
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

  toSignupScreen() {
    Navigator.pushNamed(context, '/signupScreen');
  }

  toMainScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/mainScreen', (context) => false);
  }

  toGoogleSignIn() {
    Navigator.pushNamed(context, '/googleSigninScreen');
  }
}
