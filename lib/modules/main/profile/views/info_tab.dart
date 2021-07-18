import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class InfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal + 10, vertical: kDefaultPaddingVerical),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Giới thiệu', style: kHeadingTextStyle.copyWith(fontSize: 24)),
            SizedBox(height: 5),
            Text(
              '',
              maxLines: 5,
              style: kDefaultTextStyle.copyWith(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     FlatButton(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //       shape: CircleBorder(),
            //       onPressed: () {},
            //       child: Icon(Icons.mail, color: Colors.white),
            //       color: Colors.purple,
            //     ),
            //     FlatButton(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //       shape: CircleBorder(),
            //       onPressed: () {},
            //       child: Icon(Icons.chat, color: Colors.white),
            //       color: kPrimaryColor,
            //     ),
            //     FlatButton(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //       shape: CircleBorder(),
            //       onPressed: () {},
            //       child: Icon(Icons.phone, color: Colors.white),
            //       color: Colors.green,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
