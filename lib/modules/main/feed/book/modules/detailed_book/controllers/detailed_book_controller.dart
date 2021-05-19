import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/modules/main/feed/book/modules/see_more/see_more_screen.dart';
import 'package:shaboo/data/models/post/book.dart';
import 'package:shaboo/data/models/post/post.dart';

class DetailedBookController {
  BuildContext context;
  PostBloc _postBloc;
  BookModel selectedBook;
  DetailedBookController({this.context, this.selectedBook}) {
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  uploadPost() {
    PostModel _currentPost = PostModel(
        id: this.id,
        title: title,
        description: desc,
        images: images,
        location: location,
        book: selectedBook);
    //TODO: add update logic here
    if (isEdit) {
      _postBloc.add(UpdatePost(_currentPost));
    } else {
      _postBloc.add(AddPost(_currentPost));
    }
  }

  //getter & setter
  get id => _postBloc.state.currentPost?.id;
  get title => _postBloc.state.currentPost?.title;
  get desc => _postBloc.state.currentPost?.description;
  get images => _postBloc.state.currentPost?.images;
  get location => _postBloc.state.currentPost?.location;
  get isEdit => _postBloc.state.currentPost?.isEdit ?? false;

  // Navigations

  toExit() => Navigator.pop(context);
  toSeeMoreScreen(BookModel selectedBook) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SeeMoreScreen(selectedBook: selectedBook)));
}
