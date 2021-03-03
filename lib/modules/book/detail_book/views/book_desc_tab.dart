import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class BookDescTab extends StatelessWidget {
  final String bookDesc;

  const BookDescTab({Key key, this.bookDesc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal + 10, vertical: kDefaultPaddingVerical),
      child: Text(
        bookDesc,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
