import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/model/post/post.dart';

class PostController {
  BuildContext context;
  PageController pageController;
  PostController({this.context}) {
    pageController = new PageController(initialPage: 0);
  }

  onPageChanged(int index) {}

  dispose() {
    pageController.dispose();
  }

  toNextPage() => pageController.nextPage(
      duration: Duration(milliseconds: 500), curve: Curves.ease);
  toPreviousPage() => pageController.previousPage(
      duration: Duration(milliseconds: 500), curve: Curves.ease);
  toExit() => Navigator.pop(context);

  getPost() async => await ListPost.getPosts(EOrder.ASC, 1, 10);
}
