import 'package:flutter/material.dart';

class WidgetWithLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  final Widget child;
  final Color textColor;

  const WidgetWithLabel({Key key, @required this.label, this.isRequired = false, @required this.child, this.textColor = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$label ',
            style: TextStyle(color: textColor, fontSize: 18),
            children: [isRequired ? TextSpan(text: '*', style: TextStyle(color: Colors.red)) : TextSpan(text: '')],
          ),
        ),
        SizedBox(height: 5),
        child,
      ],
    );
  }
}
