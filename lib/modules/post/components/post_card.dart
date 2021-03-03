import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/constants/ui_constants.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnailUrl;
  final double range;
  const PostCard({
    Key key,
    this.title,
    this.description,
    this.thumbnailUrl,
    this.range,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              child: CachedNetworkImage(
                imageUrl: thumbnailUrl,
                placeholder: (context, url) => LoadingWidget(
                  isImage: true,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/icons/book-placeholder.png',
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kHeadingTextStyle.copyWith(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icons/location.png', scale: 1.5),
                        SizedBox(width: 10),
                        Text(
                          range.toString() + ' km',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  description,
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
    );
  }
}
