import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedController {
  BuildContext context;
  PageController pageController;

  FeedController({this.context}) {
    pageController = new PageController(initialPage: 0);
  }

  dispose() {
    pageController.dispose();
  }

  toNextPage() => pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  toPreviousPage() => pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  toExit() => Navigator.pop(context);
}
