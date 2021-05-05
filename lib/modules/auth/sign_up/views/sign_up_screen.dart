import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:shaboo/components/stateful/custom_textfield.dart';
import 'package:shaboo/components/stateless/default_button.dart';
import 'package:shaboo/constants/ui_constants.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/modules/auth/sign_up/controllers/sign_up_controller.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = SignupController(context: context);

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
                alignment: Alignment.centerLeft,
                child: Text(
                  'Đăng kí',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: controller.emailController,
                keyboard: TextInputType.emailAddress,
                labelText: 'Email',
                icon: MdiIcons.account,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: controller.passwordController,
                labelText: 'Mật khẩu',
                isObscure: true,
                icon: MdiIcons.lock,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: controller.confirmPasswordController,
                labelText: 'Xác thực mật khẩu',
                isObscure: true,
                icon: MdiIcons.lock,
              ),
              SizedBox(height: 20),
              DefaultButton(
                onPress: () {},
                text: 'Đăng kí',
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
                      'Hoặc đăng kí với',
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
                        onPressed: controller.signInByGoogle,
                        darkMode: false,
                        text: 'Đăng kí với Google',
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
                        onPressed: controller.signInByFacebook,
                        text: '   Đăng kí với Facebook',
                        textStyle: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: controller.toLoginScreen,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Đã có tài khoản? ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: ' Đăng nhập ngay',
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
