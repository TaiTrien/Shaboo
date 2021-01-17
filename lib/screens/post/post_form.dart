import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/description/description_screen.dart';
import 'package:shaboo/screens/post/image/add_image_screen.dart';
import 'package:shaboo/screens/post/location/location_screen.dart';
import 'package:shaboo/screens/post/post_controller.dart';
import 'package:shaboo/screens/post/book/book_screen.dart';

class PostForm extends StatefulWidget {
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
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
    return SafeArea(
      child: Scaffold(
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
