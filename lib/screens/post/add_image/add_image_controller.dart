import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaboo/model/photo.dart';

class AddImageController {
  BuildContext context;
  AddImageController({this.context});
  PhotoModel _photoModel = PhotoModel();

  void onAccessPhotos() async {
    _photoModel.getPhotosFromGallery();
  }

  // void onAccessCamera() => Navigator.pushNamed(context, '/takePhotoScreen');
  void onAccessCamera() async {
    PickedFile takenPhoto = await _photoModel.getPhotoFromCamera();
    if (takenPhoto == null) return;

    final result = await ImageGallerySaver.saveFile(takenPhoto.path);
    print(result);
  }
}
