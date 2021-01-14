import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/book.dart';

class BookInfoCard extends StatelessWidget {
  const BookInfoCard({
    Key key,
    @required this.selectedBook,
  }) : super(key: key);

  final BookModel selectedBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More information',
            style: kTitleTextStyle,
          ),
          SizedBox(height: 15),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Published by: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              TextSpan(
                  children: selectedBook.publishers
                      .map((publisher) => TextSpan(
                            text: publisher["publisher"]["name"],
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ))
                      .toList()),
            ]),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Authors: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              TextSpan(
                  children: selectedBook.authors
                      .map((publisher) => TextSpan(
                            text: publisher["author"]["name"],
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ))
                      .toList()),
            ]),
          ),
          Text(
            'Book description',
            style: kTitleTextStyle,
          ),
          Text(
            selectedBook.desc,
            textAlign: TextAlign.justify,
            maxLines: 5,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            child: Text(
              'See more',
              style: TextStyle(color: kGreyColor, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
