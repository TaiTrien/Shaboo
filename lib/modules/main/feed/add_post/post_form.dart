import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/main/feed/add_post/description/views/description_screen.dart';
import 'package:shaboo/modules/main/feed/feed/controllers/feed_controller.dart';

import 'package:shaboo/modules/main/feed/add_image/views/add_image_screen.dart';
import 'package:shaboo/modules/main/feed/add_location/views/location_screen.dart';
import 'package:shaboo/modules/main/feed/book/views/book_screen.dart';
import 'package:shaboo/modules/main_screen.dart';
import 'package:shaboo/utils/notify.dart';

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
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostSucceed) {
          var _postBloc = BlocProvider.of<PostBloc>(context);
          _postBloc.add(ResetCurrentPost(null));
          Notify().success(
              message: state.currentPost?.isEdit ?? false
                  ? 'Sửa thành công'
                  : 'Tạo bài đăng thành công');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
              ModalRoute.withName("/Home"));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                onPressed: _currentPageIndex == 0
                    ? _controller.toExit
                    : _controller.toPreviousPage,
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                state.currentPost?.isEdit ?? false
                    ? 'Sửa bài đăng'
                    : 'Nhập thông tin',
                style: kHeadingTextStyle.copyWith(
                    fontSize: 22.0, color: Colors.black),
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
      },
    );
  }
}
