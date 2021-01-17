import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/model/post/image.dart';
import 'package:shaboo/model/post/photo.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/utils/notify.dart';

class AddImageController {
  PhotoModel _photoModel = PhotoModel();
  List<File> photos = List<File>();
  List<ImageModel> uploadedImages;
  PostBloc _postBloc;
  PageController pageController;

  BuildContext context;
  AddImageController({this.context, this.pageController}) {
    _postBloc = BlocProvider.of<PostBloc>(context);
    uploadedImages = List<ImageModel>();
    uploadedImages = currentPost.images ?? null;
  }

  void onAccessPhotos() async {
    var assets = await _photoModel.getPhotosFromGallery();
    if (assets.isEmpty) return;

    for (var asset in assets) {
      var path = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      photos.add(File(path));
    }
    var result = await PostApi.uploadPhoto(photos: photos);
    print(result.data);
  }

  void uploadImageFromCamera() async {
    PickedFile takenPhoto = await _photoModel.getPhotoFromCamera();
    if (takenPhoto == null) return;

    var response;
    try {
      response = await PostApi.uploadPhoto(photos: [File(takenPhoto.path)]);
    } catch (e) {
      print(e);
    }
    if (response == null) return Notify().error(message: "Upload failed");

    ImageModel uploadedImage = ImageModel.fromJson(response.data.first);

    if (uploadedImages == null)
      uploadedImages = [uploadedImage];
    else
      uploadedImages.add(uploadedImage);

    PostModel _currentPost = PostModel(
      title: title,
      description: desc,
      images: uploadedImages,
    );

    _postBloc.add(UpdateCurrentPost(_currentPost));
  }

  handleUpdateCurrentPost() {
    if (currentPost.images == null) return Notify().error(message: 'You must add least 1 image');
    toNextPage();
  }

  //getter & setters
  get currentPost => _postBloc.state.currentPost;
  get title => currentPost.title;
  get desc => currentPost.description;
  get numberOfImages => currentPost.images != null ? currentPost.images.length : 0;

  getUpLoadedImages(int index) {
    if (currentPost.images == null || index >= currentPost.images.length) return null;
    return currentPost.images[index];
  }

  // Navigators
  void toExit() => Navigator.pop(context);
  toNextPage() => pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
}
