import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/modules/main/post/book/modules/detailed_book/views/detailed_book_screen.dart';
import 'package:shaboo/models/post/book.dart';

class BookListController {
  BuildContext context;
  StreamController<List<dynamic>> _streamController;
  ScrollController scrollController;
  Stream<List<dynamic>> bookStream;
  List<dynamic> _books;

  int currentPage;
  bool hasMore;
  bool _isLoading;

  BookListController({this.context}) {
    _streamController = StreamController<List<dynamic>>.broadcast();
    scrollController = ScrollController();
    bookStream = _streamController.stream;
    _books = List<dynamic>();

    currentPage = 1;
    hasMore = true;
    _isLoading = false;

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        try {
          loadMore(currentPage: currentPage);
        } catch (e) {
          print(e);
        }
      }
    });
    refresh();
  }

  Future<void> refresh() => loadMore(clearCachedData: true);

  Future<void> loadMore({bool clearCachedData = false, int currentPage}) async {
    if (clearCachedData) {
      _books = List<dynamic>();
      hasMore = true;
      this.currentPage = 1;
    }

    if (_isLoading || !hasMore) return Future.value();

    _isLoading = true;
    this.currentPage++;

    try {
      return await ListBook.getBooks(eOrder: EOrder.ASC, page: currentPage).then((book) => {
            _isLoading = false,
            _books.addAll(book.listBook),
            hasMore = (_books.length < book.itemCount),
            _streamController.sink.add(_books),
          });
    } catch (e) {
      print(e);
    }
  }

  //Navigations
  toDetailedBookScreen(BookModel selectedBook) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedBookScreen(selectedBook: selectedBook)));

  dispose() {
    _streamController.close();
  }
}
