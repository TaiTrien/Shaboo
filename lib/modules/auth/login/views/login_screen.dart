import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shaboo/blocs/auth/auth_bloc.dart';
import 'package:shaboo/components/stateful/custom_textfield.dart';
import 'package:shaboo/components/stateless/default_button.dart';
import 'package:shaboo/constants/ui_constants.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:shaboo/modules/auth/login/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = LoginController(context: context);
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state.isLogging ?? false,
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                      controller: controller.usernameController,
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
                    Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            fontSize: 18,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    DefaultButton(
                      onPress: () {},
                      text: 'Đăng nhập',
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
                            'Hoặc đăng nhập với',
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
                              text: 'Đăng nhập bằng Google',
                              darkMode: false,
                              textStyle: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            child: FacebookSignInButton(
                              onPressed: controller.signInByFacebook,
                              text: '   Đăng nhập bằng Facebook',
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
                      child: TextButton(
                        onPressed: controller.toSignupScreen,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Không có tài khoản? ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: ' Đăng kí ngay',
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
        },
      ),
    );
  }
}
