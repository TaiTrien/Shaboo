import 'package:flutter/material.dart';
import 'package:shaboo/modules/on_boarding/components/body.dart';
import 'package:shaboo/size_config.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
