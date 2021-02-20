import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/modules/main/post/book/modules/see_more/see_more_screen.dart';
import 'package:shaboo/shared_models/post/book.dart';
import 'package:shaboo/shared_models/post/post.dart';
import 'package:shaboo/services/utils/notify.dart';

class DetailedBookController {
  BuildContext context;
  PostBloc _postBloc;
  LocationBloc _locationBloc;
  BookModel selectedBook;
  PostModel _postModel;
  DetailedBookController({this.context, this.selectedBook}) {
    _postBloc = BlocProvider.of<PostBloc>(context);
    _locationBloc = BlocProvider.of<LocationBloc>(context);
    _postModel = PostModel();
  }

  handleUploadPost() async {
    PostModel _currentPost =
        PostModel(title: title, description: desc, images: images, location: location, book: selectedBook);

    _postBloc.add(UpdateCurrentPost(_currentPost));
    var response = await _postModel.upload(post: _currentPost);
    if (response == null) return Notify().error(message: "Tạo bài đăng thất bại");

    _postBloc.add(ResetCurrentPost(null));
    _locationBloc.add(ResetCurrentLocation(null));

    Notify().success(message: "Tạo bài đăng thành công");
    toExit();
    toExit();
  }

  //getter & setter
  get title => _postBloc.state.currentPost.title;
  get desc => _postBloc.state.currentPost.description;
  get images => _postBloc.state.currentPost.images;
  get location => _postBloc.state.currentPost.location;

  // Navigations

  toExit() => Navigator.pop(context);
  toSeeMoreScreen(BookModel selectedBook) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => SeeMoreScreen(selectedBook: selectedBook)));
}
