import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class SelectorTitle extends StatelessWidget {
  final String title;
  const SelectorTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal - 5),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '$title(',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
          TextSpan(
            text: ')',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ]),
      ),
    );
  }
}
