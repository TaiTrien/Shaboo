import 'dart:io';

import 'package:shaboo/data/models/post/book.dart';
import 'package:shaboo/data/providers/remote/api/book_api.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/data/repositories/abstract/book/book_repo.dart';

class BookRepoImpl implements BookReposity {
  @override
  Future search({EOrder eOrder, int page, String bookName}) async {
    var response = await BookApi.searchBook(
        eOrder: eOrder ?? EOrder.ASC,
        page: page ?? 1,
        bookName: bookName ?? '');

    if (response != null) return ListBook.fromJson(response);
  }
}
