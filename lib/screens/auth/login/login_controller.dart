import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shaboo/blocs/auth/auth_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/model/auth/auth.dart';
import 'package:shaboo/utils/notify.dart';

class LoginController {
  AuthBloc _authBloc;
  UserBloc _userBloc;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebooklogin = FacebookLogin();
  final AuthModel _authModel = AuthModel();

  TextEditingController usernameController;
  TextEditingController passwordController;
  BuildContext context;

  LoginController({this.context}) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);

    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  Future<void> signInByGoogle() async {
    _authBloc.add(Login(true));

    var currentUser = await _authModel.googleSignIn();
    _authBloc.add(Login(false));

    if (currentUser == null) return Notify().error(message: 'Sign in failed');
    _userBloc.add(UpdateUserData(currentUser));
    toLoadingScreen();
  }

  Future<void> signInByFacebook() async {
    _authBloc.add(Login(true));
    var currentUser = await _authModel.facebookSignIn();
    _authBloc.add(Login(false));

    if (currentUser == null) return Notify().error(message: 'Sign in failed');
    _userBloc.add(UpdateUserData(currentUser));
    toLoadingScreen();
  }

  // Navigations

  toSignupScreen() => Navigator.pushNamed(context, '/signupScreen');
  toLoadingScreen() => Navigator.pushNamedAndRemoveUntil(context, '/loadingScreen', (context) => false);
  toGoogleSignIn() => Navigator.pushNamed(context, '/googleSigninScreen');
}
