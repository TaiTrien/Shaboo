import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/model/post/photo.dart';
import 'package:shaboo/utils/notify.dart';

class ImageContainerController {
  BuildContext context;
  PhotoModel _photoModel;
  PostBloc _postBloc;

  ImageContainerController({this.context}) {
    _photoModel = PhotoModel();
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  uploadImageFromCamera() async {
    var response;
    PickedFile takenPhoto = await _photoModel.getPhotoFromCamera();
    if (takenPhoto == null) return;

    try {
      response = await PostApi.uploadPhoto(photos: [File(takenPhoto.path)]);
    } catch (e) {
      print(e);
    }

    if (response == null) return Notify().error(message: "Upload failed");
    return response.data;
  }

  get uploadedImage => _postBloc.state.currentPost.images;
}
