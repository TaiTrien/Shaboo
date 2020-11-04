import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class AuthButton extends StatelessWidget {
  final Function onPress;
  final IconData icon;
  final Color backgroundColor;
  final String title;
  const AuthButton({
    Key key,
    @required this.onPress,
    this.title,
    this.icon,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
