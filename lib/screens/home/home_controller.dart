import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/model/post/book.dart';
import 'package:shaboo/screens/post/post_screen.dart';

class HomeController {
  BuildContext context;
  UserBloc _userBloc;
  HomeController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  getRecommendBooks() async => await ListBook.getRecommendBooks(EOrder.ASC, 1);
  getBooks() async => await ListBook.getBooks(eOrder: EOrder.ASC, page: 1, take: 10, bookName: '');

  get currentUser => _userBloc.state.currentUser;
  get avatarLink => _userBloc.state.currentUser.avatar;

  toPostByIdScreen(int bookId) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(bookId: bookId)));
}
