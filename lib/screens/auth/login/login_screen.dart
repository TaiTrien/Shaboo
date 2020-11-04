import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/components/custom_textfield.dart';
import 'package:shaboo/components/default_button.dart';
import 'package:shaboo/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/screens/auth/login/login_controller.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = LoginController(context: context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Shaboo',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 60,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: controller.emailController,
                keyboard: TextInputType.emailAddress,
                labelText: 'Your email',
                icon: MdiIcons.account,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: controller.passwordController,
                labelText: 'Your password',
                isObscure: true,
                icon: MdiIcons.lock,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              DefaultButton(
                press: controller.toMainScreen,
                text: 'Login',
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                        indent: 50,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      'Or login with',
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                        indent: 10,
                        endIndent: 50,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: GoogleSignInButton(
                        onPressed: controller.toGoogleSignIn,
                        darkMode: false,
                        textStyle:
                            TextStyle(fontSize: 20, color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: FacebookSignInButton(
                        onPressed: () {},
                        text: '   Sign in with Facebook',
                        textStyle: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: controller.toSignupScreen,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: ' Sign Up',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
