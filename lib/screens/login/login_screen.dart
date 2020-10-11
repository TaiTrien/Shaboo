import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/components/default_button.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/size_config.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    SizeConfig().init(context);
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
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your email',
                  suffixIcon: Icon(MdiIcons.account),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your password',
                  suffixIcon: Icon(MdiIcons.lock),
                ),
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
                press: () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Container(
                      child: Icon(
                        MdiIcons.facebook,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 25,
                    child: Container(
                      child: Icon(
                        MdiIcons.gmail,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    radius: 25,
                    child: Container(
                      child: Icon(
                        MdiIcons.linkedin,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: () {},
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
