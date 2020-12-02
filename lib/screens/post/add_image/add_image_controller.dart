import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/model/photo.dart';

class AddImageController {
  BuildContext context;
  AddImageController({this.context});
  PhotoModel _photoModel = PhotoModel();

  void onAccessPhotos() => _photoModel.getPhotosFromGallery();
  void onAccessCamera() => Navigator.pushNamed(context, '/takePhotoScreen');
}
