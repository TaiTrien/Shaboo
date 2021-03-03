import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/main/home/components/book_tile.dart';
import 'package:shaboo/modules/main/home/components/books_row.dart';
import 'package:shaboo/modules/main/home/components/see_more_row.dart';
import 'package:shaboo/modules/main/home/components/vertical_book_tile.dart';
import 'package:shaboo/modules/main/home/controllers/home_controller.dart';

import 'package:shaboo/models/post/book.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/components/stateless/search_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController _controller = HomeController(context: context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        title: Text(
          'Trang chủ',
          style: kHeadingTextStyle,
          textAlign: TextAlign.center,
        ),
        actions: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CircleAvatar(
                      radius: 18,
                      child: ClipOval(
                          child: Image.network(
                        _controller.avatarLink,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return LoadingWidget(isImage: true);
                        },
                      ))));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical, horizontal: 15),
                child: SearchBar(),
              ),
              SizedBox(height: 20),
              SeeMoreRow(
                title: 'Có thể bạn sẽ thích',
                onSeeMoreTap: _controller.toSeeMoreRecommendBooks,
              ),
              BooksRow(
                bookGetter: _controller.getRecommendBooks(),
                onMoveToScreen: _controller.toDetailedBookScreen,
              ),
              SeeMoreRow(
                title: 'Sách được đánh giá tốt',
                onSeeMoreTap: _controller.toSeeMoreHighestScoreBooks,
              ),
              BooksRow(
                bookGetter: _controller.getHighestScoreBooks(),
                onMoveToScreen: _controller.toDetailedBookScreen,
              ),
              SeeMoreRow(
                title: 'Sách có nhiều đánh giá',
                onSeeMoreTap: _controller.toSeeMoreMostReviewedBooks,
              ),
              FutureBuilder(
                  future: _controller.getMostReviewedBooks(),
                  builder: (context, _snapshot) {
                    if (_snapshot.connectionState != ConnectionState.done) {
                      return Center(child: CircularProgressIndicator());
                    } else if (_snapshot.hasError) {
                      return Center(
                        child: Text('Đã xảy ra lỗi', style: kTitleTextStyle),
                      );
                    }
                    ListBook bookList = _snapshot.data;
                    return Container(
                      height: size.height / 4,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () => _controller.toDetailedBookScreen(bookList.listBook[index]),
                                child: BooksTile(
                                  title: bookList.listBook[index].name,
                                  description: bookList.listBook[index].description,
                                  imageLink: bookList.listBook[index].thumbnailUrl,
                                ),
                              )),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
