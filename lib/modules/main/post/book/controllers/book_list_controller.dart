import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/shared_models/post/book.dart';
import 'package:shaboo/modules/main/post/book/detailed_book/views/detailed_book_screen.dart';

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

  Future<void> refresh() => loadMore(clearCachedData: true);

  Future<void> loadMore({bool clearCachedData = false, int currentPage}) async {
    if (clearCachedData) {
      _data = List<dynamic>();
      hasMore = true;
      this.currentPage = 1;
    }
    if (_isLoading || !hasMore) return Future.value();

    _isLoading = true;
    this.currentPage++;

    try {
      return await ListBook.getBooks(eOrder: EOrder.ASC, page: currentPage).then((book) => {
            _isLoading = false,
            _data.addAll(book.listBook),
            hasMore = (_data.length < book.itemCount),
            _streamController.sink.add(_data),
          });
    } catch (e) {
      print(e);
    }
  }

  toDetailedBookScreen(BookModel selectedBook) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedBookScreen(selectedBook: selectedBook)));

  dispose() {
    _streamController.close();
  }
}
