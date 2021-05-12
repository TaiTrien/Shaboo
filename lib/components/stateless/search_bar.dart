import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/book/detail_book/views/detail_book_screen.dart';

class SearchBar extends StatelessWidget {
  final dynamic dataSource;

  const SearchBar({Key key, this.dataSource}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onTap: () {
          showSearch(
              context: context,
              delegate: DataSearch(dataSource: this.dataSource));
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingHorizontal,
              vertical: kDefaultPaddingVerical,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Tìm kiếm",
            hintStyle: TextStyle(fontSize: 16),
            prefixIcon: Icon(Icons.search)),
        readOnly: true,
      ),
    );
  }
}

class DataSearch extends SearchDelegate {
  final dataSource;
  var selectedItem;

  DataSearch({this.dataSource});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(child: Image.network(selectedItem.thumbnailUrl)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: this.dataSource(query),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData)
          return Container();
        else if (snapshot.hasError)
          return Container(
            child: Center(
              child: Text('Đã xảy ra lỗi'),
            ),
          );
        else if (snapshot.data.listBook.isEmpty)
          return Container(
            child: Center(
              child: Text('Không tìm thấy kết quả'),
            ),
          );
        return ListView.builder(
            itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    selectedItem = snapshot.data.listBook[index];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailBookScreen(
                                  selectedBook: selectedItem,
                                )));
                  },
                  leading: Icon(Icons.search),
                  title: RichText(
                    text: TextSpan(
                      text: snapshot.data.listBook[index].name
                          .substring(0, query.length),
                      style: kDefaultTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: snapshot.data.listBook[index].name
                                .substring(query.length),
                            style: kDefaultTextStyle.copyWith(
                                color: kGreyColor, fontSize: 16))
                      ],
                    ),
                  ),
                ),
            itemCount: snapshot.data.listBook.length);
      },
    );
  }

  @override
  String get searchFieldLabel => "Tìm kiếm";
}
