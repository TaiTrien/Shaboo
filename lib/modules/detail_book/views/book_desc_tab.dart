import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class BookDescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal + 10, vertical: kDefaultPaddingVerical),
      child: Text(
        ' selectedBook.description',
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
