import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function onPress;
  final IconData icon;
  final Color backgroundColor;
  const CircleButton({
    Key key,
    @required this.onPress,
    this.icon,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: 25,
        child: Container(
          child: Icon(
            icon,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}
