import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/components/template_screens/error_screens/article_not_found_screen.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/components/post_card.dart';
import 'package:shaboo/screens/post/post_form.dart';
import 'package:shaboo/screens/profile/list_post_controller.dart';

class ListPost extends StatefulWidget {
  const ListPost({Key key}) : super(key: key);
  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  ListPostController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ListPostController(context: context);

    _controller.scrollController.addListener(() {
      if (_controller.scrollController.position.maxScrollExtent == _controller.scrollController.offset) {
        try {
          _controller.loadMore(currentPage: _controller.currentPage);
        } catch (e) {
          print(e);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.postStream,
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (!_snapshot.hasData || _snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (_snapshot.data.isEmpty) {
          return Center(
              child: ArticleNotFoundScreen(
            onPress: _controller.toExit,
          ));
        } else if (_snapshot.hasError) {
          return Expanded(
            child: Center(
              child: Text(
                'ERROR',
                style: TextStyle(fontSize: 20, color: kGreyColor),
              ),
            ),
          );
        } else {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: _controller.refresh,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                controller: _controller.scrollController,
                itemCount: _snapshot.data.length + 1,
                itemBuilder: (BuildContext _context, int index) {
                  if (index < _snapshot.data.length) {
                    return InkWell(
                      onTap: () => _controller.toPreviewPostScreen(_snapshot.data[index]),
                      child: PostCard(
                        key: Key(index.toString()),
                        imgUrl: _snapshot.data[index].images.length == 0
                            ? _controller.defaultImage
                            : _snapshot.data[index].images[0].link,
                        title: _snapshot.data[index].title,
                        description: _snapshot.data[index].description,
                        range: '1.5km',
                        location: _snapshot.data[index].location,
                      ),
                    );
                  } else if (_controller.hasMore) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    );
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
}
