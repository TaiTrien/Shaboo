import 'package:flutter/material.dart';

class SignupController {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;

  BuildContext context;
  SignupController({this.context}) {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    confirmPasswordController = new TextEditingController();
  }

  toLoginScreen() {
    Navigator.pop(context);
  }
}
