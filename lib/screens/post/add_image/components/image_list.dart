import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class ImageList extends StatelessWidget {
  final Function onPress;
  const ImageList({
    Key key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: 10),
      child: Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DottedBorder(
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
                ),
              );
            },
          )),
    );
  }
}
