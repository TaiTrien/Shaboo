import 'dart:core';

import 'package:shaboo/api/post_api.dart';

class BookModel {
  int _id;
  String createdAt;
  String updatedAt;
  String name;
  int version;
  List<dynamic> authors;
  String description;
  String shortDescription;
  String thumbnailUrl;
  List<dynamic> publisher;
  List<dynamic> categories;

  BookModel({
    int id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.version,
    this.authors,
    this.description,
    this.shortDescription,
    this.thumbnailUrl,
    this.publisher,
    this.categories,
  }) : this._id = id;

  get id => this._id;

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
                name: book["name"],
                version: book["version"],
                description: book["description"],
                shortDescription: book["shortDescription"],
                thumbnailUrl: book["thumbnailUrl"],
                categories: book["categories"],
                authors: book["authors"],
                publisher: book["publishers"],
              ))
          .toList();
    } catch (e) {
      print(e);
    }

    return {response.meta["itemCount"]: books};
  }

  Map<String, dynamic> toJson() => {
        'id': this._id,
        'bookName': this.name,
        'version': this.version,
        'desc': this.description,
        'shortDesc': this.shortDescription,
        'thumbnailUrl': this.thumbnailUrl,
        'categories': this.categories,
        'authors': this.authors,
        'publishers': this.publisher,
      };
}
