import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class FieldInfo extends StatelessWidget {
  final String title;
  final dynamic data;
  const FieldInfo({
    Key key,
    @required this.title,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title\n',
            style: TextStyle(
              color: kTitleColor.withOpacity(0.4),
              fontSize: 25,
            ),
          ),
          TextSpan(
            text: data.toString(),
            style: TextStyle(
              color: kTitleColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
