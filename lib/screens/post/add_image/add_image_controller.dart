import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/model/photo.dart';

class AddImageController {
  PhotoModel _photoModel = PhotoModel();
  List<File> photos = List<File>();

  BuildContext context;
  AddImageController({this.context});

  void onAccessPhotos() async {
    var assets = await _photoModel.getPhotosFromGallery();
    if (assets == null) return;

    for (var asset in assets) {
      var path = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      photos.add(File(path));
    }
    await PostApi.uploadPhoto(photos: photos);
  }

  // void onAccessCamera() => Navigator.pushNamed(context, '/takePhotoScreen');
  void onAccessCamera() async {
    PickedFile takenPhoto = await _photoModel.getPhotoFromCamera();
    if (takenPhoto == null) return;
    photos.add(File(takenPhoto.path));

    final result = await ImageGallerySaver.saveFile(takenPhoto.path);
    //await PostApi.uploadPhoto(photos: photos);
  }

  // Navigators
  void toExit() => Navigator.pop(context);
}
