import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/model/image.dart';
import 'package:shaboo/screens/add_post/add_image/components/camera.dart';

class AddImageController {
  BuildContext context;
  AddImageController({required this.context});
  ImageModel _imageModel = ImageModel();

  void onAccessPhotos() {
    _imageModel.getImageFromGallery();
  }

  void onAccessCamera() async {
    final cameras = await availableCameras();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePictureScreen(
            camera: cameras.first,
          ),
        ));
  }
}
