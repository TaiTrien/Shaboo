import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/data/models/post/image.dart';
import 'package:shaboo/data/models/post/post.dart';
import 'package:shaboo/utils/notify.dart';

class AddImageController {
  List<File> photos = [];
  List<ImageModel> uploadedImages;
  PostBloc _postBloc;
  PageController pageController;

  BuildContext context;
  AddImageController({this.context, this.pageController}) {
    _postBloc = BlocProvider.of<PostBloc>(context);
    uploadedImages = [];
    uploadedImages = currentPost.images ?? null;
  }

  handleUpdateCurrentPost() {
    if (currentPost.images == null)
      return Notify().error(message: 'Vui lòng thêm ít nhất 1 tấm ảnh');

    PostModel _currentPost = PostModel(
      id: id,
      title: title,
      description: desc,
      images: uploadedImages,
      location: location ?? null,
      book: book ?? null,
      isEdit: isEdit,
    );
    _postBloc.add(UpdateCurrentPost(_currentPost));
    toNextPage();
  }

  //getter & setters

  get currentPost => _postBloc.state.currentPost;
  get id => currentPost.id;
  get title => currentPost.title;
  get desc => currentPost.description;
  get numberOfImages =>
      currentPost.images != null ? currentPost.images.length : 0;
  get location => currentPost.location;
  get book => currentPost.book;
  get isEdit => currentPost.isEdit;

  //  Navigations
  toExit() => Navigator.pop(context);
  toNextPage() => pageController.nextPage(
      duration: Duration(milliseconds: 500), curve: Curves.ease);
}
