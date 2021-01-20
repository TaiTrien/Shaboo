import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/model/post/post.dart';

class PostByIdController {
  BuildContext context;
  int bookId;
  PostByIdController({this.context, this.bookId});

  getPost() async => await ListPost.getPosts(eOrder: EOrder.ASC, page: 1, take: 10, bookId: bookId);

  get defaultImage => "https://bitly.com.vn/pdmjnn";
  toExit() => Navigator.pop(context);
}
