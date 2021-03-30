import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/main/feed/add_post/description/views/description_screen.dart';
import 'package:shaboo/modules/main/feed/feed/controllers/feed_controller.dart';

import 'package:shaboo/modules/main/feed/add_image/views/add_image_screen.dart';
import 'package:shaboo/modules/main/feed/add_location/views/location_screen.dart';
import 'package:shaboo/modules/main/feed/book/views/book_screen.dart';

class PostForm extends StatefulWidget {
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  FeedController _controller;
  int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
    _controller = FeedController(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: _currentPageIndex == 0 ? _controller.toExit : _controller.toPreviousPage,
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          backgroundColor: Color(0xfffafafa),
          elevation: 0,
          title: Text(
            'Nhập thông tin',
            style: kHeadingTextStyle.copyWith(fontSize: 22.0, color: Colors.black),
          ),
          centerTitle: true,
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
      ),
    );
  }
}
