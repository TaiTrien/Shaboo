import 'package:flutter/material.dart';

import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = ProfileController(context: context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Profile', style: kHeadingTextStyle),
          actions: [
            FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingHorizontal + 10,
              vertical: kDefaultPaddingVerical + 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  offset: Offset(0, 5),
                  color: Color(0xFFebf2f8),
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(controller.currentUser.avatar) ??
                          controller.defaultAvatar,
                  radius: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  controller.userFullName,
                  style: TextStyle(
                    color: kTitleColor,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '\"The journey of a thousand miles begins with one step\"',
                  style: TextStyle(
                    color: kGreyColor,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPaddingVerical,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Posts\n',
                              style: TextStyle(
                                color: kTitleColor.withOpacity(0.4),
                                fontSize: 25,
                              ),
                            ),
                            TextSpan(
                              text: '05',
                              style: TextStyle(
                                color: kTitleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Books\n',
                              style: TextStyle(
                                color: kTitleColor.withOpacity(0.4),
                                fontSize: 25,
                              ),
                            ),
                            TextSpan(
                              text: '33',
                              style: TextStyle(
                                color: kTitleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Interest\n',
                              style: TextStyle(
                                color: kTitleColor.withOpacity(0.4),
                                fontSize: 25,
                              ),
                            ),
                            TextSpan(
                              text: '125',
                              style: TextStyle(
                                color: kTitleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
