import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/main/feed/book/components/book_card.dart';
import 'package:shaboo/modules/main/feed/book/controllers/book_list_controller.dart';

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
                'Không tìm thấy sách phù hợp',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else if (_snapshot.hasError) {
          return Expanded(
            child: Center(
              child: Text(
                'Đã xảy ra lỗi',
                style: TextStyle(fontSize: 18),
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
                    return GestureDetector(
                        onTap: () => _controller
                            .toDetailedBookScreen(_snapshot.data[index]),
                        child: BookCard(
                          imgUrl: _snapshot.data[index].thumbnailUrl,
                          title: _snapshot.data[index].name,
                          description: _snapshot.data[index].shortDescription,
                        ));
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
