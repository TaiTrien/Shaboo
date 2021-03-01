import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class InfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal + 10, vertical: kDefaultPaddingVerical),
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
            Text('Liên hệ', style: kHeadingTextStyle.copyWith(fontSize: 24)),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 15.0,
              children: [
                FlatButton.icon(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  onPressed: () {},
                  icon: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  label: Text('Chat',
                      style: kDefaultTextStyle.copyWith(
                        color: Colors.white,
                      )),
                  color: kPrimaryColor,
                ),
                FlatButton.icon(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  label: Text('Gọi',
                      style: kDefaultTextStyle.copyWith(
                        color: Colors.white,
                      )),
                  color: kGreenColor,
                ),
                FlatButton.icon(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  onPressed: () {},
                  icon: Icon(
                    (Icons.sms),
                    color: Colors.white,
                  ),
                  label: Text('SMS',
                      style: kDefaultTextStyle.copyWith(
                        color: Colors.white,
                      )),
                  color: kSecondaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
