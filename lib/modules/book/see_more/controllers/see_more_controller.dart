import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/data/models/post/book.dart';
import 'package:shaboo/modules/book/detail_book/views/detail_book_screen.dart';

class SeeMoreController {
  BuildContext context;
  Stream<List<dynamic>> dataStream;

  bool hasMore;
  bool _isLoading;
  int currentPage;
  List<dynamic> _dataList;
  StreamController<List<dynamic>> _streamController;
  ScrollController scrollController;
  BookType bookType;

  SeeMoreController({this.context, this.bookType}) {
    scrollController = ScrollController();
    _dataList = [];
    _streamController = StreamController<List<dynamic>>.broadcast();
    _isLoading = false;
    dataStream = _streamController.stream;
    currentPage = 0;
    hasMore = true;
    refresh();
  }
  Future<void> refresh() => loadMore(clearCachedData: true);

  Future<void> loadMore({bool clearCachedData = false, int currentPage}) async {
    if (clearCachedData) {
      _dataList = [];
      hasMore = true;
      this.currentPage = 0;
    }
    if (_isLoading || !hasMore) return Future.value();

    _isLoading = true;
    this.currentPage++;

    try {
      return await getBooks();
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getBooks() async {
    switch (this.bookType) {
      case BookType.RecommendBook:
        return await ListBook.getRecommendBooks(EOrder.ASC, currentPage).then((books) => {
              _isLoading = false,
              _dataList.addAll(books.listBook),
              hasMore = (_dataList.length < books.itemCount),
              _streamController.sink.add(_dataList),
            });
        break;
      case BookType.MostReviewBook:
        return await ListBook.getBooks(
                eOrder: EOrder.ASC, page: currentPage, take: 10, bookName: '', orderBy: EOrder.RatingCount)
            .then((books) => {
                  _isLoading = false,
                  _dataList.addAll(books.listBook),
                  hasMore = (_dataList.length < books.itemCount),
                  _streamController.sink.add(_dataList),
                });
        break;
      case BookType.HighestRateBook:
        return await ListBook.getBooks(
                eOrder: EOrder.ASC, page: currentPage, take: 10, bookName: '', orderBy: EOrder.FinalScore)
            .then((books) => {
                  _isLoading = false,
                  _dataList.addAll(books.listBook),
                  hasMore = (_dataList.length < books.itemCount),
                  _streamController.sink.add(_dataList),
                });
        break;
      default:
        return Future.value();
    }
  }

  dipose() {
    this.scrollController.dispose();
    this._streamController.close();
  }

  //Navigations
  toDetailedBookScreen(BookModel selectedBook) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailBookScreen(
                selectedBook: selectedBook,
              )));

  toExit() => Navigator.pop(context);
}
