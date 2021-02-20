import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/shared_models/post/book.dart';

class BookInfoCard extends StatelessWidget {
  const BookInfoCard({
    Key key,
    @required this.selectedBook,
  }) : super(key: key);

  final BookModel selectedBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddingVerical - 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Nhà xuất bản: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              TextSpan(
                  children: selectedBook.publisher
                      .map((publisher) => TextSpan(
                            text: publisher.name,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ))
                      .toList()),
            ]),
          ),
          SizedBox(height: 7.0),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Tác giả: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              TextSpan(
                  children: selectedBook.authors
                      .map((author) => TextSpan(
                            text: author.name,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ))
                      .toList()),
            ]),
          ),
          SizedBox(height: 10.0),
          Text(
            'Giới thiệu sách',
            style: kTitleTextStyle,
          ),
          SizedBox(height: 7.0),
          Text(
            selectedBook.description,
            textAlign: TextAlign.justify,
            maxLines: 5,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 7.0),
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
