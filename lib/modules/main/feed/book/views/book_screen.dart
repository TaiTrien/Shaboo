import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/data/models/post/book.dart';
import 'package:shaboo/data/repositories/implement/book/book_repo_impl.dart';
import 'package:shaboo/modules/main/feed/book/components/book_list.dart';
import 'package:shaboo/components/stateless/search_bar.dart';
import 'package:shaboo/constants/ui_constants.dart';

import 'package:shaboo/modules/main/feed/book/modules/detailed_book/views/detailed_book_screen.dart';

class BookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height),
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingHorizontal),
                    width: double.infinity,
                    height: 50,
                    child: SearchBar(
                      onItemSelected: (selectedItem) =>
                          this.toDetailedBookScreen(context, selectedItem),
                      dataSource: (query) => Future.delayed(
                          const Duration(seconds: 1),
                          () => RepositoryProvider.of<BookRepoImpl>(context)
                              .search(bookName: query)),
                    ),
                  ),
                  SizedBox(height: 20),
                  BookList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  toDetailedBookScreen(context, BookModel selectedBook) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DetailedBookScreen(selectedBook: selectedBook)));
}
