import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/components/template_screens/error_screens/article_not_found_screen.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/screens/post/components/post_card.dart';
import 'package:shaboo/screens/post/post_controller.dart';
import 'package:shaboo/screens/post/post_form.dart';

class PostScreen extends StatefulWidget {
  final int bookId;

  const PostScreen({Key key, this.bookId}) : super(key: key);
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PostController _controller;
  String dropdownValue = 'One';
  @override
  void initState() {
    super.initState();
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
            automaticallyImplyLeading: false,
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
            child: FutureBuilder(
                future: _controller.getPost(widget.bookId),
                builder: (context, _snapshot) {
                  if (!_snapshot.hasData || _snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  } else if (_snapshot.data.listPost.isEmpty) {
                    return Center(
                        child: ArticleNotFoundScreen(
                      onPress: _controller.toExit,
                    ));
                  }
                  ListPost list = _snapshot.data;
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: list.listPost.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => _controller.toPreviewPostScreen(list.listPost[index]),
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

  Widget dropdown() => DropdownButton<String>(
        value: dropdownValue,
        // icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        // elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
}
