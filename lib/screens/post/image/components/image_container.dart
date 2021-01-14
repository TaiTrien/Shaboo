import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/image.dart';

class ImageContainer extends StatelessWidget {
  final ImageModel uploadedImage;
  final Function onPress;

  const ImageContainer({Key key, this.uploadedImage, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return uploadedImage == null
        ? DottedBorder(
            color: Colors.black,
            strokeWidth: 1,
            child: Container(
              height: 100,
              width: 80,
              child: IconButton(
                icon: Icon(Icons.photo_camera, size: 50),
                onPressed: onPress,
              ),
            ),
          )
        : Container(
            height: 100,
            width: 80,
            child: Image.network(
              "$kPrefixUrl" + uploadedImage.link,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return CircularProgressIndicator();
              },
            ),
          );
  }
}
