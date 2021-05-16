import 'package:flutter/material.dart';
import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/post/components/post_card.dart';
import 'package:shaboo/modules/post/list_post/controllers/list_post_controller.dart';

class ListPostWidget extends StatefulWidget {
  final PostType postType;
  final int bookId;
  const ListPostWidget({Key key, this.postType, this.bookId}) : super(key: key);
  @override
  _ListPostWidgetState createState() => _ListPostWidgetState();
}

class _ListPostWidgetState extends State<ListPostWidget> {
  ListPostController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ListPostController(
        context: context, postType: widget.postType, bookId: widget.bookId);

    _controller.scrollController.addListener(() {
      if (_controller.scrollController.position.maxScrollExtent ==
          _controller.scrollController.offset) {
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
        if (!_snapshot.hasData ||
            _snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (_snapshot.data.isEmpty) {
          return Container(
            child: Center(
              child: Text('Hiện tại chưa có bài đăng nào'),
            ),
          );
        } else if (_snapshot.hasError) {
          return Container(
            child: Center(
              child: Text('Đã xảy ra lỗi'),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: _controller.refresh,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddingHorizontal + 10,
                vertical: kDefaultPaddingVerical,
              ),
              child: ListView.separated(
                controller: _controller.scrollController,
                itemBuilder: (BuildContext _context, int index) {
                  if (index < _snapshot.data.length) {
                    return GestureDetector(
                      onTap: () => _controller
                          .toPreviewPostScreen(_snapshot.data[index]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          color: Colors.transparent,
                          child: PostCard(
                            title: _snapshot.data[index].title,
                            description: _snapshot.data[index].description,
                            thumbnailUrl: _snapshot.data[index].images[0].link,
                            range: 15,
                          ),
                        ),
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
                itemCount: _snapshot.data.length + 1,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: kBorderColor);
                },
              ),
            ),
          );
        }
      },
    );
  }
}
