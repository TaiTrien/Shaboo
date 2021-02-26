import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/models/post/image.dart';
import 'package:shaboo/models/post/post.dart';
import 'package:shaboo/providers/remote/api/post_api.dart';
import 'package:shaboo/utils/notify.dart';
import 'package:shaboo/utils/photo.dart';

class ImageContainerController {
  BuildContext context;
  PostBloc _postBloc;
  StreamController _streamController;
  List<ImageModel> uploadedImages;

  ImageContainerController({this.context}) {
    _postBloc = BlocProvider.of<PostBloc>(context);
    _streamController = StreamController<ImageModel>.broadcast();
    uploadedImages = List<ImageModel>();
  }

  Future<dynamic> uploadImageFromCamera({File takenPhoto}) async {
    var response;
    try {
      response = await PostApi.uploadPhoto(photos: [takenPhoto]);
    } catch (e) {
      print(e);
    }

    if (response == null) return Notify().error(message: "Upload failed");

    ImageModel uploadedImage = ImageModel.fromJson(response.data.first);
    _streamController.sink.add(uploadedImage);
    updateCurrentPostImages(uploadedImage: uploadedImage);
  }

  updateCurrentPostImages({ImageModel uploadedImage}) {
    uploadedImages = currentPost.images ?? null;

    if (uploadedImages == null)
      uploadedImages = [uploadedImage];
    else
      uploadedImages.add(uploadedImage);

    PostModel _currentPost = PostModel(
      title: title,
      description: desc,
      images: uploadedImages,
      location: location ?? null,
      book: book ?? null,
    );
    _postBloc.add(UpdateCurrentPost(_currentPost));
  }

  removeUploadedImage({ImageModel uploadedImage}) {
    uploadedImages = currentPost.images ?? null;
    uploadedImages.removeWhere((image) => image.imageID == uploadedImage.imageID);

    PostModel _currentPost = PostModel(
      title: title,
      description: desc,
      images: uploadedImages,
      location: location ?? null,
      book: book ?? null,
    );
    _postBloc.add(UpdateCurrentPost(_currentPost));
  }

  Future<File> getImageFromCamera() async {
    PickedFile takenPhoto = await Photo.getPhotoFromCamera();
    if (takenPhoto == null) return null;
    return File(takenPhoto.path);
  }

  bool hasData({int index}) {
    if (currentPost.images == null) return false;
    if (currentPost.images.length <= index) return false;
    return true;
  }

  dipose() {
    _streamController.close();
  }

  //getter & setters
  get currentPost => _postBloc.state.currentPost;
  get title => currentPost.title;
  get desc => currentPost.description;
  get location => currentPost.location;
  get book => currentPost.book;

  get numberOfImages => currentPost.images != null ? currentPost.images.length : 0;
  get imageUploadStream => _streamController.stream;
}
