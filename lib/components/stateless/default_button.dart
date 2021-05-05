import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

import '../../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.onPress,
    this.circular,
    this.color,
  }) : super(key: key);
  final String text;
  final Function onPress;
  final double circular;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circular ?? 5)),
        color: color ?? kPrimaryColor,
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
