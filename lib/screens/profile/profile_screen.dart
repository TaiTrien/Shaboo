import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/components/popup_menu.dart';

import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/profile/profile_controller.dart';

import 'components/field_info.dart';

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
            PopupMenu(
              onSelect: controller.onMenuSelect,
              items: [
                PopupMenuItem(
                  value: MenuValue.SETTINGS,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Transform(
                      transform: Matrix4.translationValues(-16, 0.0, 0.0),
                      child: Text("Settings"),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: MenuValue.SIGNOUT,
                  child: ListTile(
                    leading: Icon(MdiIcons.logout),
                    title: Transform(
                      transform: Matrix4.translationValues(-16, 0.0, 0.0),
                      child: Text("Sign out"),
                    ),
                  ),
                ),
              ],
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
                      FieldInfo(
                        title: 'Posts',
                        data: 10,
                      ),
                      FieldInfo(
                        title: 'Books',
                        data: 33,
                      ),
                      FieldInfo(
                        title: 'Interest',
                        data: 125,
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
