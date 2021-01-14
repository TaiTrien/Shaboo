import 'package:flutter/material.dart';
import 'package:shaboo/components/default_button.dart';
import 'package:shaboo/constants.dart';

class BottomButton extends StatelessWidget {
  final Function onPress;
  final String title;
  const BottomButton({
    Key key,
    @required this.onPress,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingHorizontal,
        vertical: kDefaultPaddingVerical,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: kGreyColor.withOpacity(0.1),
              width: 1.0,
            ),
          )),
      child: DefaultButton(
        onPress: onPress,
        text: title,
      ),
    );
  }
}
