import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/screens/post/preview/preview_screen.dart';

class PostController {
  BuildContext context;
  PageController pageController;
  PostController({this.context}) {
    pageController = new PageController(initialPage: 0);
  }

  dispose() {
    pageController.dispose();
  }

  toPreviewPostScreen(PostModel postModel) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewPostScreen(id: postModel.id)));

  toNextPage() => pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  toPreviousPage() => pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  toExit() => Navigator.pop(context);

  getPost() async => await ListPost.getPosts(eOrder: EOrder.ASC, page: 1, take: 10);

  get defaultImage => "https://bitly.com.vn/pdmjnn";
}
