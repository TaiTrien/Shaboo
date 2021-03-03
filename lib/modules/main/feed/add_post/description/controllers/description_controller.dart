import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/models/post/post.dart';
import 'package:shaboo/utils/notify.dart';

class DescriptionController {
  BuildContext context;
  TextEditingController titleController;
  TextEditingController descController;
  PageController pageController;
  PostBloc _postBloc;

  DescriptionController({this.context, this.pageController}) {
    titleController = TextEditingController();
    descController = TextEditingController();
    _postBloc = BlocProvider.of<PostBloc>(context);
    titleController.text = currentPost == null ? "" : currentPost.title;
    descController.text = currentPost == null ? "" : currentPost.description;
  }

  handleUpdateCurrentPost() {
    String title = titleController.text.trim();
    String desc = descController.text.trim();

    if (title.isEmpty) return Notify().error(message: 'VUi lòng điền tiêu đề của bài đăng');
    if (desc.isEmpty) return Notify().error(message: 'Bạn chưa mô tả bài đăng của mình');

    PostModel _currentPost = PostModel(
      title: title,
      description: desc,
      images: images ?? null,
      location: location ?? null,
      book: book ?? null,
    );
    _postBloc.add(UpdateCurrentPost(_currentPost));
    toNextPage();
    outFocus();
  }

  dispose() {
    titleController.dispose();
    descController.dispose();
  }

  outFocus() => FocusScope.of(context).requestFocus(new FocusNode());
  toNextPage() => pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);

  get currentPost => _postBloc.state.currentPost;
  get images => currentPost != null ? currentPost.images : null;
  get location => currentPost != null ? currentPost.location : null;
  get book => currentPost != null ? currentPost.book : null;
  get numberOfImages => currentPost.images != null ? currentPost.images.length : 0;
}
