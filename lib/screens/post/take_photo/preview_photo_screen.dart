import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class PreviewPhotoScreen extends StatelessWidget {
  final String imagePath;

  const PreviewPhotoScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display the Picture'),
        backgroundColor: kPrimaryColor,
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
