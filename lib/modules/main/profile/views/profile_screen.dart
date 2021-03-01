import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/modules/detail_book/views/reviews_tab.dart';
import 'package:shaboo/modules/main/post/add_post/post_form.dart';
import 'package:shaboo/modules/main/profile/components/header_info.dart';
import 'package:shaboo/modules/main/profile/components/list_post.dart';
import 'package:shaboo/modules/main/profile/controllers/profile_controller.dart';
import 'package:shaboo/components/stateless/popup_menu.dart';

import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/main/profile/views/info_tab.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    _controller = ProfileController(context: context);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  _handleTabChange() {
    setState(() {});
  }

  Widget _floatingBtn() {
    switch (_tabController.index) {
      case 1:
        return FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.edit),
          backgroundColor: kPrimaryColor,
        );
        break;
      case 2:
        return FloatingActionButton(
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
            child: Icon(Icons.add));
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: NestedScrollView(
        body: TabBarView(
          children: [
            InfoTab(),
            ReviewsTab(),
            ListPost(),
          ],
          controller: _tabController,
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                floating: true,
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: size.height / 4,
                title: Text('Trang cá nhân', style: kHeadingTextStyle),
                elevation: 0.0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: [
                  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(height: constraints.maxHeight - 50);
                  }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(_controller.currentUser.avatar) ?? _controller.defaultAvatar,
                        radius: 50),
                  )
                ])),
                actions: [
                  PopupMenu(onSelect: _controller.onMenuSelect, items: [
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
                        ))
                  ])
                ]),
            SliverHeaderInfo(
              userName: _controller.userFullName,
              quote: '“The journey of a thousand miles begins with one step”',
            ),
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.white,
              titleSpacing: 0.0,
              title: TabBar(
                labelColor: Colors.black,
                labelStyle: kDefaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                indicatorColor: kSecondaryColor,
                unselectedLabelColor: kGreyColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(text: 'Miêu tả'),
                  Tab(text: 'Đánh giá(10)'),
                  Tab(text: 'Trao đổi(10)'),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
      ),
      floatingActionButton: _floatingBtn(),
    ));
  }
}
