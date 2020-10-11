import 'package:flutter/material.dart';
import 'package:shaboo/screens/on_boarding/components/body.dart';
import 'package:shaboo/size_config.dart';

class OnBoardingScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
