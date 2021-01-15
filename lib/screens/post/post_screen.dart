import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/description/description_screen.dart';
import 'package:shaboo/screens/post/image/add_image_screen.dart';
import 'package:shaboo/screens/post/location/location_screen.dart';
import 'package:shaboo/screens/post/post_controller.dart';
import 'package:shaboo/screens/post/book/book_screen.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PostController _controller;
  int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
    _controller = PostController(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _currentPageIndex == 0 ? _controller.toExit : _controller.toPreviousPage,
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          'Fill your info',
          style: kHeadingTextStyle.copyWith(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(MdiIcons.eye),
          ),
        ],
      ),
      body: PageView(
        physics: new NeverScrollableScrollPhysics(),
        controller: _controller.pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          DescriptionScreen(pageController: _controller.pageController),
          AddImageScreen(pageController: _controller.pageController),
          LocationScreen(pageController: _controller.pageController),
          BookScreen(),
        ],
      ),
    );
  }
}
