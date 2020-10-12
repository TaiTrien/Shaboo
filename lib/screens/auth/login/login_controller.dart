import 'package:flutter/cupertino.dart';

class LoginController {
  TextEditingController emailController;
  TextEditingController passwordController;
  BuildContext context;
  LoginController({this.context}) {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  toSignupScreen() {
    Navigator.pushNamed(context, '/signupScreen');
  }

  toMainScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/mainScreen', (context) => false);
  }
}
