import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/screens/home/posts_by_id_book/post_by_id_screen.dart';

class PostByIdController {
  BuildContext context;
  int bookId;
  PostByIdController({this.context, this.bookId}) {
    getPostsById();
  }

  getPost() async => await ListPost.getPosts(EOrder.ASC, 1, 10);
  getPostsById() async {
    var res = await ListPost.getPostsById(EOrder.ASC, 1, 10, 1);
    print(res);
  }

  get defaultImage => "https://bitly.com.vn/pdmjnn";
}
