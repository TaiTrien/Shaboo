import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/photo.dart';

class AddImageController {
  PhotoModel _photoModel = PhotoModel();
  List<File> photos = List<File>();

  BuildContext context;
  AddImageController({this.context});

  void onAccessPhotos() async {
    var assets = await _photoModel.getPhotosFromGallery();
    if (assets.isEmpty) return;

    for (var asset in assets) {
      var path = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      photos.add(File(path));
    }
    //await PostApi.uploadPhoto(photos: photos);
  }

  void onAccessCamera() async {
    PickedFile takenPhoto = await _photoModel.getPhotoFromCamera();
    if (takenPhoto == null) return;
    photos.add(File(takenPhoto.path));

    await ImageGallerySaver.saveFile(takenPhoto.path);
    //await PostApi.uploadPhoto(photos: photos);
  }

  Future<void> selectPickImageOption() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose your resource'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                'Sign out',
                style: TextStyle(
                  color: Colors.red[600],
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  // Navigators
  void toExit() => Navigator.pop(context);
}
