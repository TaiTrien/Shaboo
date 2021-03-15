import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/data/models/post/post.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/modules/post/preview/views/preview_screen.dart';

class ListPostController {
  BuildContext context;
  PostType postType;
  Stream<List<dynamic>> postStream;
  bool hasMore;
  bool _isLoading;
  int currentPage;
  List<dynamic> _postList;
  StreamController<List<dynamic>> _streamController;
  ScrollController scrollController;
  int bookId;

  ListPostController({this.context, this.postType, this.bookId}) {
    scrollController = ScrollController();
    _postList = List<dynamic>();
    _streamController = StreamController<List<dynamic>>.broadcast();
    _isLoading = false;
    postStream = _streamController.stream;
    currentPage = 0;
    hasMore = true;
    refresh();
  }

  Future<void> refresh() => loadMore(clearCachedData: true);

  Future<void> loadMore({bool clearCachedData = false, int currentPage}) async {
    if (clearCachedData) {
      _postList = [];
      hasMore = true;
      this.currentPage = 0;
    }
    if (_isLoading || !hasMore) return Future.value();

    _isLoading = true;
    this.currentPage++;

    try {
      return await getPosts();
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getPosts() async {
    switch (this.postType) {
      case PostType.Owned:
        return await ListPost.getPosts(eOrder: EOrder.ASC, page: currentPage, take: 10, owned: true).then((post) => {
              _isLoading = false,
              _postList.addAll(post.listPost),
              hasMore = (_postList.length < post.itemCount),
              _streamController.sink.add(_postList),
            });
        break;
      case PostType.Feed:
        return await ListPost.getPosts(eOrder: EOrder.ASC, page: currentPage, take: 10).then((post) => {
              _isLoading = false,
              _postList.addAll(post.listPost),
              hasMore = (_postList.length < post.itemCount),
              _streamController.sink.add(_postList),
            });

        break;
      case PostType.BasedOnBook:
        return await ListPost.getPosts(eOrder: EOrder.ASC, page: currentPage, take: 10, bookId: this.bookId)
            .then((post) => {
                  _isLoading = false,
                  _postList.addAll(post.listPost),
                  hasMore = (_postList.length < post.itemCount),
                  _streamController.sink.add(_postList),
                });
        break;
      default:
        return Future.value();
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
