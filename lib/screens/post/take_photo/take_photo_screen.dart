import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/take_photo/preview_photo_screen.dart';
import 'package:shaboo/screens/post/take_photo/take_photo_controller.dart';

class TakePhotoScreen extends StatefulWidget {
  //final CameraDescription camera;

  const TakePhotoScreen({
    Key key,
    // this.camera,
  }) : super(key: key);

  @override
  TakePhotoScreenState createState() => TakePhotoScreenState();
}

class TakePhotoScreenState extends State<TakePhotoScreen> {
  //CameraController _controller;
  //Future<void> _initializeControllerFuture;
  TakePhotoController _controller;
  String imagePath = '';

  @override
  void initState() {
    super.initState();
    // _controller = CameraController(
    //   widget.camera,
    //   ResolutionPreset.medium,
    // );
    //_initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) _controller = TakePhotoController(context: context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Take your book picture'),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _controller.initCamera(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller.cameraController);
              } else {
                return Center(
                    child: ModalProgressHUD(
                  inAsyncCall: true,
                  child: Container(),
                ));
              }
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: double.infinity,
              height: 80,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: imagePath.isEmpty ? null : DecorationImage(image: FileImage(File(imagePath)), fit: BoxFit.cover),
                    ),
                    // child: imagePath.isEmpty ? null :),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar:
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.camera_alt,
          color: Colors.black,
        ),
        onPressed: () async {
          _controller.takePhoto();
          // try {
          //   await _initializeControllerFuture;
          //   final path = join(
          //     (await getTemporaryDirectory()).path,
          //     '${DateTime.now()}.png',
          //   );
          //   await _controller.takePicture(path);

          //   setState(() => imagePath = path);
          // } catch (e) {
          //   print(e);
          // }
        },
      ),
    );
  }
}
