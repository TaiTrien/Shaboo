import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/book.dart';
import 'package:shaboo/screens/home/components/book_tile.dart';
import 'package:shaboo/screens/home/components/vertical_book_tile.dart';
import 'package:shaboo/screens/home/home_controller.dart';
import 'package:shaboo/screens/post/components/loading_widget.dart';
import 'package:shaboo/components/search_bar.dart';

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
          'Dành cho bạn',
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
          constraints: BoxConstraints(maxHeight: size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical, horizontal: 15),
                child: SearchBar(),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Dựa vào thể loại sách của bạn',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      'Xem thêm',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: kGreyColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
                height: size.height / 3,
                child: FutureBuilder(
                    future: _controller.getRecommendBooks(),
                    builder: (context, _snapshot) {
                      if (_snapshot.connectionState != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      } else if (_snapshot.hasError) {
                        return Center(
                          child: Text('Đã xảy ra lỗi', style: kTitleTextStyle),
                        );
                      }
                      ListBook recommendBookList = _snapshot.data;
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: recommendBookList.listBook.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => _controller.toPostByIdScreen(recommendBookList.listBook[index].id),
                            child: VerticalBookTile(
                              title: recommendBookList.listBook[index].name,
                              imageLink: recommendBookList.listBook[index].thumbnailUrl,
                            ),
                          ),
                          scrollDirection: Axis.horizontal,
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Có thể bạn sẽ thích',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      'Xem thêm',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: kGreyColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                    future: _controller.getBooks(),
                    builder: (context, _snapshot) {
                      if (_snapshot.connectionState != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      } else if (_snapshot.hasError) {
                        return Center(
                          child: Text('Đã xảy ra lỗi', style: kTitleTextStyle),
                        );
                      }
                      ListBook bookList = _snapshot.data;
                      return ListView.builder(
                          itemCount: bookList.listBook.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () => _controller.toPostByIdScreen(bookList.listBook[index].id),
                                child: BooksTile(
                                  title: bookList.listBook[index].name,
                                  description: bookList.listBook[index].description,
                                  imageLink: bookList.listBook[index].thumbnailUrl,
                                ),
                              ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
