import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shaboo/model/post/book.dart';

class BookListController {
  BuildContext context;
  BookModel bookModel;
  Stream<List<dynamic>> bookStream;
  bool hasMore;
  bool _isLoading;
  int currentPage;
  List<dynamic> _data;
  StreamController<List<dynamic>> _streamController;
  ScrollController scrollController;

  BookListController({this.context}) {
    bookModel = BookModel();
    scrollController = ScrollController();
    _data = List<dynamic>();
    _streamController = StreamController<List<dynamic>>.broadcast();
    _isLoading = false;
    bookStream = _streamController.stream;
    currentPage = 1;
    hasMore = true;
    refresh();
  }

  Future<void> refresh() {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false, int currentPage}) async {
    if (clearCachedData) {
      _data = List<dynamic>();
      hasMore = true;
    }
    if (_isLoading || !hasMore) return Future.value();

    _isLoading = true;
    this.currentPage++;

    try {
      return await bookModel.getBooks(page: currentPage).then((book) => {
            _isLoading = false,
            _data.addAll(book),
            hasMore = (_data.length < 130),
            _streamController.add(_data),
          });
    } catch (e) {
      print(e);
    }
  }
}
