import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/components/loading_widget.dart';
import 'package:shaboo/screens/post/image/image_container_controller.dart';

class ImageContainer extends StatefulWidget {
  @override
  _ImageContainerState createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  ImageContainerController _controller;
  bool hasData;

  @override
  void initState() {
    super.initState();
    _controller = new ImageContainerController(context: context);
    hasData = false;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dipose();
  }

  @override
  Widget build(BuildContext context) {
    return !hasData
        ? DottedBorder(
            color: Colors.black,
            strokeWidth: 1,
            child: Container(
              height: 150,
              width: 100,
              child: IconButton(
                icon: Icon(Icons.photo_camera, size: 50),
                onPressed: () async {
                  File takenPhoto = await _controller.getImageFromCamera();
                  if (takenPhoto == null) return;
                  _controller.uploadImageFromCamera(takenPhoto: takenPhoto);
                  setState(() => hasData = true);
                },
              ),
            ),
          )
        : StreamBuilder(
            stream: _controller.imageUploadStream,
            builder: (BuildContext _context, AsyncSnapshot _snapshot) {
              if (_snapshot.connectionState == ConnectionState.waiting)
                return Container(
                  height: 150,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              else if (_snapshot.hasData) {
                return Container(
                  height: 150,
                  width: 100,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 100,
                          child: Image.network(
                            _snapshot.data.link,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: LoadingWidget(isImage: true));
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.close_rounded, size: 20, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              } else if (_snapshot.hasError) {
                return Container(
                  height: 150,
                  width: 100,
                  child: Center(
                    child: Text(
                      'Lỗi đăng tải',
                      style: TextStyle(fontSize: 20, color: kGreyColor),
                    ),
                  ),
                );
              }
              return Container(); // to ensure widget will return something
            },
          );
  }
}
