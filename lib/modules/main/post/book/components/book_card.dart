import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/shared_components/loading_widget.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String description;
  final String imgUrl;
  const BookCard({
    Key key,
    @required this.title,
    @required this.description,
    @required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                child: Hero(
                  tag: 'img-${this.key}',
                  child: CachedNetworkImage(
                    imageUrl: this.imgUrl,
                    placeholder: (context, url) => Container(
                      height: 120.0,
                      width: 100.0,
                      child: LoadingWidget(
                        isImage: true,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/icons/book-placeholder.png',
                      fit: BoxFit.fill,
                      height: 120.0,
                      width: 100.0,
                    ),
                    fit: BoxFit.cover,
                    height: 120.0,
                    width: 100.0,
                  ),
                ),
              ),
              elevation: 0,
            ),
            SizedBox(width: 7.0),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Hero(
                    tag: 'title-${this.key}',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        this.title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0365B0),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    this.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 7.0),
          ],
        ),
      ),
    );
  }
}
