import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/components/post_card.dart';
import 'package:shaboo/screens/post/post_controller.dart';
import 'package:shaboo/screens/post/post_form.dart';

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
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Trao đổi sách',
              style: kHeadingTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Column(
              children: [
                Expanded(
                  child: PostCard(
                    itemCount: 15,
                  ),
                ),
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
      ),
    );
  }
}
