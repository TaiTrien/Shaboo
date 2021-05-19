import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';

import 'package:shaboo/data/models/post/post.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/modules/main/feed/add_post/post_form.dart';
import 'package:shaboo/modules/main/feed/pop_contact/views/popup_contact.dart';

class PreviewPostController {
  BuildContext context;
  PostModel _postModel;
  PostBloc _postBloc;
  PreviewPostController({this.context}) {
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  getPost(int id) async {
    _postModel = await PostModel.getPost(id);
    return _postModel;
  }

  toPopupContact(String userId) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupContact(userId: userId);
      });

  toEditPost(PostModel postModel) {
    postModel.setIsEdit = true;
    PostModel _currentPost = postModel;
    _postBloc.add(UpdateCurrentPost(_currentPost));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostForm()));
  }

  toExit() => Navigator.pop(context);

  List<Widget> getImgSlider() {
    final List<Widget> imageSliders = _postModel.images
        .map((item) => Container(
              child: Container(
                child: item.link != null
                    ? Image.network(
                        item.link,
                        fit: BoxFit.cover,
                        width: 1000.0,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return LoadingWidget(isImage: true);
                        },
                      )
                    : Image.asset(
                        'assets/icons/book-placeholder.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ))
        .toList();
    return imageSliders;
  }
}
