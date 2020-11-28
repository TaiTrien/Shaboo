import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaboo/constants.dart';

class AddImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          'Images',
          style: kHeadingTextStyle.copyWith(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
              child: Row(
                children: [
                  Text(
                    'Your images',
                    style: kTitleTextStyle,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '9',
                    style: kTitleTextStyle.copyWith(
                      fontWeight: FontWeight.normal,
                      color: kGreyColor,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
