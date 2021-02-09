import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/shared_models/post/post.dart';
import 'package:shaboo/modules/main/post/preview/views/preview_screen.dart';
import 'package:shaboo/constants/api_constants.dart';

class ListPostController {
  BuildContext context;
  Stream<List<dynamic>> postStream;
  bool hasMore;
  bool _isLoading;
  int currentPage;
  List<dynamic> _postList;
  StreamController<List<dynamic>> _streamController;
  ScrollController scrollController;

  ListPostController({this.context}) {
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
      return await ListPost.getPosts(eOrder: EOrder.ASC, page: currentPage, take: 10, owned: true).then((post) => {
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
    scrollController.dispose();
  }

  toPreviewPostScreen(PostModel postModel) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewPostScreen(id: postModel.id)));

  toExit() => Navigator.pop(context);
  get defaultImage => "https://bitly.com.vn/pdmjnn";
}
