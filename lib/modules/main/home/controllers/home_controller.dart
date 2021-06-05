import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/modules/main/feed/feed/views/feed_screen.dart';
import 'package:shaboo/data/models/post/book.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/modules/book/detail_book/views/detail_book_screen.dart';
import 'package:shaboo/modules/book/see_more/views/see_more_screen.dart';

class HomeController {
  BuildContext context;
  UserBloc _userBloc;
  HomeController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  getRecommendBooks() async => await ListBook.getRecommendBooks(EOrder.ASC, 1);
  getMostReviewedBooks() async => await ListBook.getBooks(
      eOrder: EOrder.DESC,
      page: 1,
      take: 10,
      bookName: '',
      orderBy: EOrder.RatingCount);

  getHighestScoreBooks() async => await ListBook.getBooks(
      eOrder: EOrder.DESC,
      page: 1,
      take: 10,
      bookName: '',
      orderBy: EOrder.FinalScore);

  get currentUser => _userBloc.state.currentUser;
  get avatarLink => _userBloc.state.currentUser.avatar;

  toPostByIdScreen(int bookId) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => FeedScreen()));

  toDetailedBookScreen(BookModel selectedBook) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailBookScreen(
                selectedBook: selectedBook,
              )));

  toSeeMoreRecommendBooks() => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SeeMoreScreen(
                bookType: BookType.RecommendBook,
                screenHeader: 'Có thể bạn sẽ thích',
              )));

  toSeeMoreMostReviewedBooks() => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SeeMoreScreen(
                bookType: BookType.MostReviewBook,
                screenHeader: 'Sách có nhiều đánh giá',
              )));

  toSeeMoreHighestScoreBooks() => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SeeMoreScreen(
                bookType: BookType.HighestRateBook,
                screenHeader: 'Sách được đánh giá tốt',
              )));
}
