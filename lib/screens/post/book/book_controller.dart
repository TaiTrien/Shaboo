import 'package:flutter/material.dart';
import 'package:shaboo/model/post/book.dart';

class BookController {
  BuildContext context;
  TextEditingController searchController;
  BookModel bookModel;
  int pageNumber;

  BookController({this.context}) {
    searchController = TextEditingController();
    pageNumber = 1;
    bookModel = BookModel();
  }
}
