import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/book/detail_book/views/detail_book_screen.dart';
import 'package:shaboo/utils/strings.dart';

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

  Stream<dynamic> dataStream() async* {
    yield await this.dataSource(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: this.dataStream(),
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
                    toDetailScreen(context, selectedItem);
                  },
                  leading: Icon(Icons.search),
                  title: RichText(
                    text: TextSpan(
                      children: StringUtils.highlightOccurrences(
                          snapshot.data.listBook[index].name, query),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
            itemCount: snapshot.data.listBook.length);
      },
    );
  }

  @override
  String get searchFieldLabel => "Tìm kiếm";

  toDetailScreen(context, selectedBook) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailBookScreen(
                selectedBook: selectedBook,
              )));
}
