import 'package:flutter/material.dart';
import 'package:shaboo/screens/post/components/loading_widget.dart';

class VerticalBookTile extends StatelessWidget {
  final String title;
  final String imageLink;
  const VerticalBookTile({
    Key key,
    @required this.title,
    @required this.imageLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 20.0),
      width: size.width / 3,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Container(
          height: size.height / 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
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
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
