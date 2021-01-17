import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/model/post/image.dart';
import 'package:shaboo/model/post/photo.dart';
import 'package:shaboo/utils/notify.dart';

class ImageContainerController {
  BuildContext context;
  PhotoModel _photoModel;
  PostBloc _postBloc;
  StreamController _streamController;

  ImageContainerController({this.context}) {
    _photoModel = PhotoModel();
    _postBloc = BlocProvider.of<PostBloc>(context);
    _streamController = StreamController<ImageModel>();
  }

  Future<File> getImageFromCamera() async {
    PickedFile takenPhoto = await _photoModel.getPhotoFromCamera();
    if (takenPhoto == null) return null;
    return File(takenPhoto.path);
  }

  uploadImageFromCamera({File takenPhoto}) async {
    var response;
    try {
      response = await PostApi.uploadPhoto(photos: [takenPhoto]);
    } catch (e) {
      print(e);
    }

    if (response == null) return Notify().error(message: "Upload failed");

    ImageModel uploadedImage = ImageModel.fromJson(response.data.first);
    _streamController.sink.add(uploadedImage);
  }

  dipose() {
    _streamController.close();
  }

  get uploadedImage => _postBloc.state.currentPost.images;
  get imageUploadStream => _streamController.stream;
}
