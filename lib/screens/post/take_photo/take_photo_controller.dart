import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaboo/model/image.dart';

class TakePhotoController {
  BuildContext context;
  TakePhotoController({this.context}) {
    initCamera();
  }

  var cameras;
  CameraDescription camera;
  var _cameraController;
  ImageModel _imageModel = ImageModel();

  Future<void> initCamera() async {
    cameras = await availableCameras();
    CameraDescription camera = cameras.first;
    _cameraController = CameraController(camera, ResolutionPreset.medium);
    await _cameraController.initialize();
  }

  void takePhoto() async {
    _imageModel.takePhoto(_cameraController);
  }

  get cameraController => this._cameraController;
}
