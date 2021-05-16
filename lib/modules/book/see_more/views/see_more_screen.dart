import 'package:flutter/material.dart';
import 'package:shaboo/components/stateless/custom_listtile_with_image.dart';
import 'package:shaboo/components/template_screens/error_screens/article_not_found_screen.dart';
import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/book/see_more/controllers/see_more_controller.dart';

class SeeMoreScreen extends StatefulWidget {
  final String screenHeader;
  final BookType bookType;

  const SeeMoreScreen({Key key, this.screenHeader, this.bookType})
      : super(key: key);
  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  SeeMoreController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        SeeMoreController(context: context, bookType: widget.bookType);

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
    _controller.dipose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.screenHeader,
          style: kHeadingTextStyle,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: StreamBuilder(
        stream: _controller.dataStream,
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (!_snapshot.hasData ||
              _snapshot.connectionState == ConnectionState.waiting) {
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
                  'Lỗi',
                  style: TextStyle(fontSize: 20, color: kGreyColor),
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: _controller.refresh,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                controller: _controller.scrollController,
                itemCount: _snapshot.data.length + 1,
                itemBuilder: (BuildContext _context, int index) {
                  if (index < _snapshot.data.length) {
                    return CustomListTileWithImage(
                      imageLink: _snapshot.data[index].thumbnailUrl,
                      subTitle: _snapshot.data[index].description,
                      title: _snapshot.data[index].name,
                      onPress: () => _controller
                          .toDetailedBookScreen(_snapshot.data[index]),
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
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            );
          }
        },
      ),
    );
  }
}
