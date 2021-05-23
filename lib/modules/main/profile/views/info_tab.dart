import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class InfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddingHorizontal + 10,
            vertical: kDefaultPaddingVerical),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Giới thiệu', style: kHeadingTextStyle.copyWith(fontSize: 24)),
            SizedBox(height: 5),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
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
