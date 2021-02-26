import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/modules/main/post/add_post/post_form.dart';
import 'package:shaboo/modules/main/profile/components/list_post.dart';
import 'package:shaboo/modules/main/profile/controllers/profile_controller.dart';
import 'package:shaboo/components/stateless/popup_menu.dart';

import 'package:shaboo/constants/ui_constants.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = ProfileController(context: context);
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Trang cá nhân', style: kHeadingTextStyle),
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
        body: ConstrainedBox(
          constraints: BoxConstraints(minHeight: size.height),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(controller.currentUser.avatar) ?? controller.defaultAvatar,
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
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Bài đăng của bạn',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      'Xem tất cả',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: kGreyColor),
                    ),
                  ],
                ),
              ),
              ListPost(),
            ],
          ),
        ),
        floatingActionButton: IconButton(
          iconSize: 60.0,
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
          color: Color(0xFF0365B0),
          icon: Icon(MdiIcons.plusCircle),
          onPressed: () => {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: PostForm(),
              ),
            )
          },
        ),
      ),
    );
  }
}
