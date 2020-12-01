import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/model/image.dart';
import 'package:shaboo/screens/post/take_photo/take_photo_screen.dart';

class AddImageController {
  BuildContext context;
  AddImageController({this.context});
  ImageModel _imageModel = ImageModel();

  void onAccessPhotos() => _imageModel.getImageFromGallery();
  void onAccessCamera() => Navigator.pushNamed(context, '/takePhotoScreen');
}
