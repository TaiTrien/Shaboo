import 'package:flutter/material.dart';
import 'package:shaboo/models/post/book.dart';

class BookController {
  BuildContext context;
  TextEditingController searchController;
  BookModel bookModel;

  BookController({this.context}) {
    searchController = TextEditingController();
    bookModel = BookModel();
  }
}
