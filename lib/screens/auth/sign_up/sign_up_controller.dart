import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shaboo/blocs/auth/auth_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/model/auth.dart';
import 'package:shaboo/utils/notify.dart';

class SignupController {
  AuthBloc _authBloc;
  UserBloc _userBloc;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebooklogin = FacebookLogin();
  final Auth _authModel = Auth();

  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;

  BuildContext context;

  SignupController({this.context}) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);

    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    confirmPasswordController = new TextEditingController();
  }

  Future<void> signInByGoogle() async {
    _authBloc.add(Login(true));
    var currentUser = await _authModel.googleSignIn();
    _authBloc.add(Login(false));

    if (currentUser == null) return Notify().error(message: 'Sign in failed');
    _userBloc.add(UpdateUserData(currentUser));
    toMainScreen();
  }

  Future<void> signInByFacebook() async {
    _authBloc.add(Login(true));
    var currentUser = await _authModel.facebookSignIn();
    _authBloc.add(Login(false));

    if (currentUser == null) return Notify().error(message: 'Sign in failed');
    _userBloc.add(UpdateUserData(currentUser));
    toMainScreen();
  }

  //Navigators
  toMainScreen() => Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (context) => false);
  toLoginScreen() => Navigator.pop(context);
}
