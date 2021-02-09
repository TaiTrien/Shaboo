import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/shared_models/post/post.dart';
import 'package:shaboo/modules/main/post/preview/views/preview_screen.dart';
import 'package:shaboo/constants/api_constants.dart';

class FeedController {
  BuildContext context;
  PageController pageController;
  Stream<List<dynamic>> postStream;
  bool hasMore;
  bool _isLoading;
  int currentPage;
  int bookId;
  List<dynamic> _postList;
  StreamController<List<dynamic>> _streamController;
  ScrollController scrollController;

  FeedController({this.context, this.bookId}) {
    pageController = new PageController(initialPage: 0);
    scrollController = ScrollController();
    _postList = List<dynamic>();
    _streamController = StreamController<List<dynamic>>.broadcast();
    _isLoading = false;
    postStream = _streamController.stream;
    currentPage = 1;
    hasMore = true;
    refresh();
  }
  Future<void> refresh() => loadMore(clearCachedData: true);

  Future<void> loadMore({bool clearCachedData = false, int currentPage}) async {
    if (clearCachedData) {
      _postList = List<dynamic>();
      hasMore = true;
      this.currentPage = 1;
    }
    if (_isLoading || !hasMore) return Future.value();

    _isLoading = true;
    this.currentPage++;

    try {
      return await ListPost.getPosts(eOrder: EOrder.ASC, page: currentPage, take: 10, bookId: bookId).then((post) => {
            _isLoading = false,
            _postList.addAll(post.listPost),
            hasMore = (_postList.length < post.itemCount),
            _streamController.sink.add(_postList),
          });
    } catch (e) {
      print(e);
    }
  }

  dispose() {
    pageController.dispose();
  }

  toPreviewPostScreen(PostModel postModel) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewPostScreen(id: postModel.id)));

  toNextPage() => pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  toPreviousPage() => pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  toExit() => Navigator.pop(context);

  getPost() async => await ListPost.getPosts(eOrder: EOrder.ASC, page: 1, take: 10, bookId: bookId);

  get defaultImage => "https://bitly.com.vn/pdmjnn";
}
