import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shaboo/blocs/auth/auth_bloc.dart';

class LoginController {
  AuthBloc _authBloc;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebooklogin = FacebookLogin();

  TextEditingController usernameController;
  TextEditingController passwordController;
  BuildContext context;

  LoginController({this.context}) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  Future<dynamic> signInWithGoogle() async {
    _authBloc.add(Login(true));
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
          await _auth.signInWithCredential(credential).then((value) {
        _authBloc.add(Login(false));
        return value;
      });

      final User user = authResult.user;
      var googleToken = googleSignInAuthentication.accessToken;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        print('signInWithGoogle succeeded: $user');
        print('Google token: $googleToken');
        toMainScreen();
        return '$user';
      }
    } catch (e) {
      print(e);
    }
    _authBloc.add(Login(false));
    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

  Future<dynamic> signInWithFacebook() async {
    facebooklogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    _authBloc.add(Login(true));
    final result = await facebooklogin.logIn(['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      final credential = FacebookAuthProvider.credential(
        result.accessToken.token,
      );

      // Lấy thông tin User qua credential có giá trị token đã đăng nhập
      final user = (await _auth.signInWithCredential(credential)).user;
      _authBloc.add(Login(false));
      return user;
    }
    _authBloc.add(Login(false));
    return null;
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
