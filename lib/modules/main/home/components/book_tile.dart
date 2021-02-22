import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

import 'package:shaboo/shared_components/stateless/loading_widget.dart';

class BooksTile extends StatelessWidget {
  final String imageLink, title, description;
  BooksTile({
    @required this.description,
    @required this.title,
    @required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 6,
      width: size.width * 0.8,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: kDefaultPaddingVerical),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(left: 120),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  subtitle: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kGreyColor),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  imageLink,
                  height: 150,
                  width: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return LoadingWidget(isImage: true);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
