import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  final TextInputType keyboard;
  final bool isObscure;
  final IconData icon;

  const CustomTextField({
    Key key,
    @required this.controller,
    this.labelText,
    this.keyboard,
    this.isObscure = false,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      keyboardType: this.keyboard,
      obscureText: this.isObscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: this.labelText,
        suffixIcon: Icon(this.icon),
      ),
    );
  }
}
