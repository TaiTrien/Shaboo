import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/modules/main/post/book/modules/detailed_book/views/detailed_book_screen.dart';
import 'package:shaboo/modules/main/post/feed/views/feed_screen.dart';
import 'package:shaboo/models/post/book.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/modules/detail_book/views/detail_book_screen.dart';

class HomeController {
  BuildContext context;
  UserBloc _userBloc;
  HomeController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  getRecommendBooks() async => await ListBook.getRecommendBooks(EOrder.ASC, 1);
  getBooks() async => await ListBook.getBooks(eOrder: EOrder.ASC, page: 1, take: 10, bookName: '');
  getMostReviewedBooks() async =>
      await ListBook.getBooks(eOrder: EOrder.ASC, page: 1, take: 10, bookName: '', orderBy: EOrder.RatingCount);
  getHighestScoreBooks() async =>
      await ListBook.getBooks(eOrder: EOrder.ASC, page: 1, take: 10, bookName: '', orderBy: EOrder.FinalScore);

  get currentUser => _userBloc.state.currentUser;
  get avatarLink => _userBloc.state.currentUser.avatar;

  toPostByIdScreen(int bookId) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => FeedScreen(bookId: bookId)));

  toDetailedBookScreen(BookModel selectedBook) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailBookScreen()));
  //  toDetailedBookScreen(BookModel selectedBook) =>
  // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedBookScreen(selectedBook: selectedBook)));
}
