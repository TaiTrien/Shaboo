import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shaboo/api/auth_api.dart';

import 'package:shaboo/blocs/auth/auth_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/model/user.dart';
import 'package:shaboo/utils/notify.dart';
import 'package:shaboo/utils/store.dart';

class LoginController {
  AuthBloc _authBloc;
  UserBloc _userBloc;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebooklogin = FacebookLogin();

  TextEditingController usernameController;
  TextEditingController passwordController;
  BuildContext context;

  LoginController({this.context}) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);

    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  Future<dynamic> signInByGoogle() async {
    _authBloc.add(Login(true));

    await Firebase.initializeApp();
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      var idToken = googleSignInAuthentication.idToken;
      var uid = googleSignInAccount.id;
      if (idToken == null || uid == null) return;

      var respone = await AuthApi.signInByGoogle(userID: uid, idToken: idToken);
      if (respone == null) return Notify().error(message: 'Sign in failed');

      var token = respone.token["accessToken"];
      Store.setToken(token);

      var userData = respone.data;
      ShabooUser currentUser = new ShabooUser(
        userID: userData["id"],
        firstName: userData["firstName"],
        lastName: userData["lastName"],
        userName: userData["username"],
        email: userData["email"],
        phone: userData["phone"],
        avatar: userData["avatar"],
      );

      _userBloc.add(UpdateUserData(currentUser));
      toMainScreen();
    } catch (e) {
      print(e);
    }
    _authBloc.add(Login(false));
    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    await _auth.signOut();
    Navigator.pushNamed(context, '/loginScreen');
  }

  Future<dynamic> signInByFacebook() async {
    facebooklogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    _authBloc.add(Login(true));
    try {
      final result = await facebooklogin.logIn(['email']);

      var uid = result.accessToken.userId;
      var idToken = result.accessToken.token;
      if (idToken == null || uid == null) return;

      var respone =
          await AuthApi.signInByFacebook(userID: uid, idToken: idToken);
      if (respone == null) return Notify().error(message: 'Sign in failed');

      var token = respone.token["accessToken"];
      Store.setToken(token);

      var userData = respone.data;
      ShabooUser currentUser = new ShabooUser(
        userID: userData["id"],
        firstName: userData["firstName"],
        lastName: userData["lastName"],
        userName: userData["username"],
        email: userData["email"],
        phone: userData["phone"],
        avatar: userData["avatar"],
      );

      _userBloc.add(UpdateUserData(currentUser));
      toMainScreen();
    } catch (e) {
      print(e);
    }
    _authBloc.add(Login(false));
    return null;
  }

  Future<void> signOutFacebook() async {
    await facebooklogin.logOut();
    await _auth.signOut();
    Navigator.pushNamed(context, '/loginScreen');
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
