import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class SeeMoreRow extends StatelessWidget {
  final Function onSeeMoreTap;
  final String title;
  const SeeMoreRow({
    Key key,
    @required this.onSeeMoreTap,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          GestureDetector(
            onTap: onSeeMoreTap,
            child: Text(
              'Xem thêm',
              overflow: TextOverflow.ellipsis,
              style: kDefaultTextStyle.copyWith(color: kGreyColor),
            ),
          ),
        ],
      ),
    );
  }
}
