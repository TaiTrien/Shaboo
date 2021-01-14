import 'dart:core';

import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/model/post/author.dart';
import 'package:shaboo/model/post/category.dart';
import 'package:shaboo/model/post/publisher.dart';

class BookModel {
  int _id;
  String createdAt;
  String updatedAt;
  String bookName;
  int version;
  String desc;
  String shortDesc;
  String thumbnailUrl;
  List<dynamic> authors;
  List<dynamic> categories;
  List<dynamic> publishers;

  BookModel({
    int id,
    this.createdAt,
    this.updatedAt,
    this.bookName,
    this.version,
    this.desc,
    this.shortDesc,
    this.thumbnailUrl,
    this.categories,
    this.authors,
    this.publishers,
  }) : this._id = id;

  Future<Map<int, List<dynamic>>> getBooks({int page, String bookName}) async {
    List<dynamic> books;
    var response = await PostApi.getBooks(page: page, bookName: bookName);
    if (response == null) return null;
    try {
      books = response.data
          .map((book) => new BookModel(
                id: book["id"],
                createdAt: book["createdAt"],
                updatedAt: book["updatedAt"],
                bookName: book["name"],
                version: book["version"],
                desc: book["description"],
                shortDesc: book["shortDescription"],
                thumbnailUrl: book["thumbnailUrl"],
                categories: book["categories"],
                authors: book["author"],
                publishers: book["publishers"],
              ))
          .toList();
    } catch (e) {
      print(e);
    }

    return {response.meta["itemCount"]: books};
  }

  Map<String, dynamic> toJson() => {
        'id': this._id,
        'bookName': this.bookName,
        'version': this.version,
        'desc': this.desc,
        'shortDesc': this.shortDesc,
        'thumbnailUrl': this.thumbnailUrl,
        'categories': this.categories,
        'authors': this.authors,
        'publishers': this.publishers,
      };
}
