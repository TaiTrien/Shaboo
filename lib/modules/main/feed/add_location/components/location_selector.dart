import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class LocationSelector extends StatelessWidget {
  final String location;
  final Function onPress;
  const LocationSelector({
    Key key,
    @required this.location,
    @required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Colors.blueGrey,
        onTap: onPress,
        child: Container(
          width: double.infinity,
          color: Colors.white70,
          padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVerical),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                this.location,
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
