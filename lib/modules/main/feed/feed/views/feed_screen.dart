import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/modules/main/feed/add_post/post_form.dart';
import 'package:shaboo/modules/main/feed/feed/controllers/feed_controller.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/post/list_post/views/list_post.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key key}) : super(key: key);
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  FeedController _controller;
  @override
  void initState() {
    super.initState();
    _controller = FeedController(context: context);
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Trao đổi sách',
          style: kHeadingTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListPost(postType: PostType.Feed),
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
    );
  }
}
