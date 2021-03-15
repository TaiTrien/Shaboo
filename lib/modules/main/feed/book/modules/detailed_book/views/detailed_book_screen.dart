import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shaboo/modules/main/feed/book/modules/detailed_book/components/book_info_card.dart';
import 'package:shaboo/modules/main/feed/book/modules/detailed_book/controllers/detailed_book_controller.dart';
import 'package:shaboo/components/stateless/bottom_button.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/data/models/post/book.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';

class DetailedBookScreen extends StatelessWidget {
  final BookModel selectedBook;

  const DetailedBookScreen({Key key, this.selectedBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _controller = DetailedBookController(context: context, selectedBook: this.selectedBook);
    var random = new Random();
    return SafeArea(
      child: Scaffold(
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
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.network(
                            selectedBook.thumbnailUrl,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return LoadingWidget(isImage: true);
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close, size: 30),
                            onPressed: _controller.toExit,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(selectedBook.name,
                      style: kTitleTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  Wrap(
                    spacing: 10,
                    children: selectedBook.categories
                        .map(
                          (category) => Chip(
                            label: Text(
                              category.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color((random.nextDouble() * 0xFF5781).toInt()).withOpacity(1.0),
                          ),
                        )
                        .toList(),
                  ),
                  GestureDetector(
                    onTap: () => _controller.toSeeMoreScreen(selectedBook),
                    child: BookInfoCard(selectedBook: selectedBook),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomButton(
          onPress: _controller.handleUploadPost,
          title: 'Chọn tựa sách này',
        ),
      ),
    );
  }
}
