import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/book.dart';

class SeeMoreScreen extends StatelessWidget {
  final BookModel selectedBook;

  const SeeMoreScreen({Key key, this.selectedBook}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          'Book description',
          style: kHeadingTextStyle.copyWith(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: size.height),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPaddingVerical,
              horizontal: kDefaultPaddingHorizontal - 5,
            ),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.network(
                        selectedBook.thumbnailUrl,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CircularProgressIndicator();
                        },
                      ),
                      Text(
                        selectedBook.desc,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
