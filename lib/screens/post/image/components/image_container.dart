import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/image/components/image_with_close_btn.dart';
import 'package:shaboo/screens/post/image/image_container_controller.dart';

class ImageContainer extends StatefulWidget {
  final id;

  const ImageContainer({Key key, this.id}) : super(key: key);
  @override
  _ImageContainerState createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  ImageContainerController _controller;
  bool isUploading;

  @override
  void initState() {
    super.initState();
    _controller = new ImageContainerController(context: context);
    isUploading = false;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dipose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.hasData(index: widget.id))
      return ImageWithCloseBtn(
        onPress: () {},
        url: _controller.currentPost.images[widget.id].link,
      );
    else if (isUploading)
      return StreamBuilder(
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
            return ImageWithCloseBtn(
              onPress: () {},
              url: _snapshot.data.link,
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
    return DottedBorder(
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
            setState(() => isUploading = true);
          },
        ),
      ),
    );
  }
}
