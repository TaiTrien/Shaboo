import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shaboo/blocs/auth/auth_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/modules/auth/login/models/auth.dart';
import 'package:shaboo/modules/updateInfo/validator.dart';
import 'package:shaboo/utils/notify.dart';

class SignupController {
  AuthBloc _authBloc;
  UserBloc _userBloc;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebooklogin = FacebookLogin();
  final AuthModel _authModel = AuthModel();

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

  Future<void> signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String reEnterPassword = confirmPasswordController.text.trim();

    if (!Validator.isEmail(email)) {
      return Notify().error(message: 'Email không khả dụng');
    } else if (email == '' || email == null) {
      return Notify().error(message: 'Vui lòng nhập email');
    } else if (password == '' || password == null) {
      return Notify().error(message: 'Vui lòng nhập mật khẩu');
    } else if (reEnterPassword == '' || reEnterPassword == null) {
      return Notify().error(message: 'Vui lòng xác thực mật khẩu');
    } else if (password != reEnterPassword)
      return Notify().error(message: 'Mật khẩu nhập lại không khớp');
    else if (!Validator.isPassword(password)) {
      return Notify().error(message: 'Mật khẩu phải dài hơn 8 kí tự');
    } else {
      _authBloc.add(SignUp(email: email, password: password));
    }
  }

  // Navigations

  toMainScreen() => Navigator.pushNamedAndRemoveUntil(
      context, '/mainScreen', (context) => false);
  toLoginScreen() => Navigator.pop(context);
  toLoadingScreen() => Navigator.pushNamedAndRemoveUntil(
      context, '/loadingScreen', (context) => false);
}
