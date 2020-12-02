import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/model/image.dart';

class AddImageController {
  BuildContext context;
  AddImageController({this.context});
  ImageModel _imageModel = ImageModel();

  void onAccessPhotos() => _imageModel.getImageFromGallery();
  void onAccessCamera() => Navigator.pushNamed(context, '/takePhotoScreen');
}
