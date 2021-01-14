import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/book.dart';

class DetailedBookScreen extends StatelessWidget {
  final BookModel selectedBook;

  const DetailedBookScreen({Key key, this.selectedBook}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                  child: Image.network(
                    selectedBook.thumbnailUrl,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator();
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(selectedBook.bookName,
                    style: kTitleTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                Wrap(
                    //children: selectedBook.categories.map((e) => Chip(label: e.name)).toList(),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
