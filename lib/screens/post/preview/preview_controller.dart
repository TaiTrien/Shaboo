import 'package:flutter/cupertino.dart';
import 'package:shaboo/model/post/post.dart';

class PreviewPostController {
  BuildContext context;
  PostModel _postModel;
  PreviewPostController({this.context});

  getPost(int id) async {
    _postModel = await PostModel.getPost(id);
    return _postModel;
  }

  List<Widget> getImgSlider() {
    final List<Widget> imageSliders = _postModel.images
        .map((item) => Container(
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item.link, fit: BoxFit.cover, width: 1000.0)),
              ),
            ))
        .toList();
    return imageSliders;
  }
}
