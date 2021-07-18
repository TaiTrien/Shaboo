import 'package:flutter/material.dart';
import 'package:shaboo/components/stateless/avatar.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/constants/ui_constants.dart';

class ReviewTile extends StatelessWidget {
  final String urlImage;
  final String title;
  final String subTitle;
  final Function onPress;
  const ReviewTile({
    Key key,
    @required this.urlImage,
    @required this.title,
    this.subTitle,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // leading: CircleAvatar(
        //     radius: 18,
        //     child: ClipOval(
        //         child: Image.network(
        //       urlImage,
        //       fit: BoxFit.cover,
        //       loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
        //         if (loadingProgress == null) return child;
        //         return LoadingWidget(isImage: true);
        //       },
        //     ))),
        leading: Avatar(
          avatarUrl: urlImage,
          radius: 18,
        ),
        title: Text(
          title ?? 'Title',
          maxLines: 1,
          style: kHeadingTextStyle.copyWith(
            fontSize: 20,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subTitle ?? 'Subtitle',
          maxLines: 3,
          style: kDefaultTextStyle.copyWith(fontSize: 18),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
