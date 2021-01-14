import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/utils/notify.dart';

class DescriptionController {
  BuildContext context;
  TextEditingController titleController;
  TextEditingController descriptionController;
  PostBloc _postBloc;

  DescriptionController({this.context}) {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  handleUpdateCurrentPost() {
    String title = titleController.text.trim();
    String desc = titleController.text.trim();

    if (title.isEmpty) return Notify().error(message: 'Post title must be filled');
    if (desc.isEmpty) return Notify().error(message: 'Post description must be filled');

    PostModel _currentPost = PostModel(title: title, desc: desc);
    _postBloc.add(UpdateCurrentPost(_currentPost));
  }
}
