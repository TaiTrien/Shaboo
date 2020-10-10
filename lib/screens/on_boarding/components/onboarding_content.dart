import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.subTitle,
    this.image,
    this.title,
  }) : super(key: key);
  final String title, subTitle, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Container(
          height: getProportionateScreenHeight(250),
          child: SvgPicture.asset(image),
        ),
        SizedBox(
          height: getProportionateScreenHeight(100),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: getProportionateScreenWidth(10),
        ),
        Text(
          subTitle,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
