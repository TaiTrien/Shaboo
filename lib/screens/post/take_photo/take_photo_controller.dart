import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaboo/model/photo.dart';

class TakePhotoController {
  var _cameras;
  var _cameraController;
  CameraDescription _camera;

  BuildContext context;
  PhotoModel _photoModel = PhotoModel();

  TakePhotoController({this.context}) {
    initCamera();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _camera = _cameras.first;
    _cameraController = CameraController(_camera, ResolutionPreset.medium);
    await _cameraController.initialize();
  }

  Future<dynamic> takePhoto() async {
    return _photoModel.takePhoto(_cameraController);
  }

  void onAccessPhotos() => _photoModel.getPhotosFromGallery();
  //Navigators
  void toReturn() => Navigator.pop(context);
  //Getters && Setters
  get cameraController => this._cameraController;
}
