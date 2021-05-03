import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onTap: () {
          showSearch(context: context, delegate: DataSearch());
        },
        onChanged: (value) => print(value),
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
  final cities = ['HCM', 'Hn', 'USA', 'TEst', 'test 2', 'test 3'];
  final recentCities = ['test 2', 'test 3'];
  var selectedItem = '';

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
      child: Text(selectedItem),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCities
        : cities
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                selectedItem = suggestionList[index];
                showResults(context);
              },
              leading: Icon(Icons.bookmarks),
              title: RichText(
                text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: kDefaultTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: kDefaultTextStyle.copyWith(
                            color: kGreyColor, fontSize: 16))
                  ],
                ),
              ),
            ),
        itemCount: suggestionList.length);
  }

  @override
  String get searchFieldLabel => "Tìm kiếm";
}
