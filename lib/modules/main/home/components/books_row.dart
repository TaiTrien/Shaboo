import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/main/home/components/vertical_book_tile.dart';

class BooksRow extends StatelessWidget {
  final Future<dynamic> bookGetter;
  final Function onMoveToScreen;

  const BooksRow({
    Key key,
    @required this.bookGetter,
    this.onMoveToScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
      height: size.height / 3,
      child: FutureBuilder(
          future: bookGetter,
          builder: (context, _snapshot) {
            if (_snapshot.connectionState != ConnectionState.done || !_snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (_snapshot.hasError) {
              return Center(
                child: Text('Đã xảy ra lỗi', style: kTitleTextStyle),
              );
            } else if (_snapshot.data.listBook.isEmpty) {
              return Center(
                child: Text('Không tìm thấy cuốn sách phù hợp', style: TextStyle(color: kGreyColor, fontSize: 18)),
              );
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: _snapshot.data.listBook.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => onMoveToScreen(_snapshot.data.listBook[index]),
                  child: VerticalBookTile(
                    title: _snapshot.data.listBook[index].name,
                    imageLink: _snapshot.data.listBook[index].thumbnailUrl,
                  ),
                ),
                scrollDirection: Axis.horizontal,
              ),
            );
          }),
    );
  }
}
