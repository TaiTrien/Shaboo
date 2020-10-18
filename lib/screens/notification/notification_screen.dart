import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/constants.dart';

import 'components/notification_board.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Text(
              'Notifications',
              style: kHeadingTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: kHeadingTextStyle.copyWith(
                    fontSize: 25,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(MdiIcons.notificationClearAll),
                ),
              ],
            ),
            SizedBox(height: 15),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: size.height * 0.2),
              child: NotificationBoard(
                itemCount: 3,
              ),
            ),
            Divider(
              color: Colors.black,
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Yesterday',
                  style: kHeadingTextStyle.copyWith(
                    fontSize: 25,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    MdiIcons.notificationClearAll,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: NotificationBoard(
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
