import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/book/book_list_controller.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  BookListController _controller;
  @override
  void initState() {
    super.initState();
    _controller = BookListController(context: context);
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
      stream: _controller.bookStream,
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (!_snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (_snapshot.data.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                'No matchingbook was found',
                style: TextStyle(fontSize: 20, color: kGreyColor),
              ),
            ),
          );
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
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                controller: _controller.scrollController,
                separatorBuilder: (context, index) => Divider(),
                itemCount: _snapshot.data.length + 1,
                itemBuilder: (BuildContext _context, int index) {
                  if (index < _snapshot.data.length) {
                    return GestureDetector(
                      onTap: () => _controller.toDetailedBookScreen(_snapshot.data[index]),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPaddingHorizontal,
                            vertical: kDefaultPaddingVerical,
                          ),
                          child: ListTile(
                            leading: Image.network(
                              _snapshot.data[index].thumbnailUrl,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return CircularProgressIndicator();
                              },
                            ),
                            title: Text(
                              _snapshot.data[index].bookName,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              _snapshot.data[index].shortDesc,
                              maxLines: 3,
                              textAlign: TextAlign.justify,
                            ),
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
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(
                          child: Text(
                        'Nothing more to load!',
                        style: TextStyle(fontSize: 18),
                      )),
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
