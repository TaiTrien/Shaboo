import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/components/loading_widget.dart';

class BooksTile extends StatelessWidget {
  final String imageLink, title, description;
  BooksTile({@required this.description, @required this.title, @required this.imageLink});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 200,
        width: double.infinity,
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: 160,
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
                  margin: EdgeInsets.only(left: 140),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    subtitle: Text(
                      description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kGreyColor),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  imageLink,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return LoadingWidget(isImage: true);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
