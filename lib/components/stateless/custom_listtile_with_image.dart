import 'package:flutter/material.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/constants/ui_constants.dart';

class CustomListTileWithImage extends StatelessWidget {
  final String imageLink;
  final String title;
  final String subTitle;
  final Function onPress;
  const CustomListTileWithImage({
    Key key,
    @required this.imageLink,
    @required this.title,
    @required this.subTitle,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                  minHeight: 100,
                  maxWidth: 120,
                  maxHeight: 150,
                ),
                child: Image.network(
                  imageLink,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return LoadingWidget(isImage: true);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: kHeadingTextStyle.copyWith(
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subTitle,
                      maxLines: 5,
                      style: kDefaultTextStyle.copyWith(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
