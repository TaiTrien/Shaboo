import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/screens/home/posts_by_id_book/post_by_id_controller.dart';
import 'package:shaboo/screens/post/components/post_card.dart';

class PostByIdScreen extends StatelessWidget {
  final int bookId;

  const PostByIdScreen({Key key, this.bookId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PostByIdController _controller = PostByIdController(context: context, bookId: bookId);
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xfffafafa),
            elevation: 0,
            title: Container(
              child: Text(
                'Trao đổi sách',
                style: kHeadingTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: FutureBuilder(
                future: _controller.getPost(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  }

                  ListPost list = snapshot.data;
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: list.listPost.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          // onTap: () => _controller
                          //     .toPreviewPostScreen(list.listPost[index]),
                          child: PostCard(
                            key: Key(index.toString()),
                            imgUrl: list.listPost[index].images.length == 0
                                ? _controller.defaultImage
                                : list.listPost[index].images[0].link,
                            title: list.listPost[index].title,
                            description: list.listPost[index].description,
                            range: '1.5km',
                            location: list.listPost[index].location,
                          ),
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }
}
