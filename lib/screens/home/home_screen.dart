import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/home/components/book_tile.dart';
import 'package:shaboo/screens/home/components/vertical_book_tile.dart';
import 'package:shaboo/screens/post/components/loading_widget.dart';
import 'package:shaboo/components/search_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        state.currentUser.avatar,
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
                child: ListView.builder(
                  itemBuilder: (context, index) => VerticalBookTile(
                    title: 'hihihi',
                    imageLink: 'https://bitly.com.vn/ndbgoi',
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 20),
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
                child: ListView.builder(
                    itemBuilder: (context, index) => BooksTile(
                          title: 'Ông già và biển cả',
                          description: 'Ngày xửa ngày xưa',
                          imageLink: "https://bitly.com.vn/ndbgoi",
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
