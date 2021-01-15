import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/model/post/book.dart';
import 'package:shaboo/screens/post/book/see_more/see_more_screen.dart';

class DetailedBookController {
  BuildContext context;
  PostBloc _postBloc;

  DetailedBookController({this.context});

  handleUploadPost() {}
  //navigators
  toExit() => Navigator.pop(context);
  toSeeMoreScreen(BookModel selectedBook) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => SeeMoreScreen(selectedBook: selectedBook)));
}
