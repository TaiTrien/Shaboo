import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  final TextInputType keyboard;
  final bool isObscure;
  final IconData icon;
  final Color mainColor;

  const CustomTextField({
    Key key,
    @required this.controller,
    this.labelText,
    this.keyboard,
    this.isObscure = false,
    this.icon,
    this.mainColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      keyboardType: this.keyboard,
      obscureText: this.isObscure,
      decoration: InputDecoration(
        enabledBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: mainColor ?? kPrimaryColor),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: mainColor ?? kPrimaryColor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor ?? kPrimaryColor),
        ),
        labelText: this.labelText,
        labelStyle: TextStyle(color: mainColor ?? kPrimaryColor),
        suffixIcon: Icon(
          this.icon,
          color: mainColor ?? kPrimaryColor,
        ),
      ),
    );
  }
}
