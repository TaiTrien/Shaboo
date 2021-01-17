import 'dart:core';

import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/model/post/author.dart';
import 'package:shaboo/model/post/category.dart';
import 'package:shaboo/model/post/publisher.dart';

class BookModel {
  int _id;
  String name;
  int version;
  String description;
  String shortDescription;
  String thumbnailUrl;
  List<AuthorModel> authors;
  List<PublisherModel> publisher;
  List<CategoryModel> categories;

  BookModel({
    int id,
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

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      name: json['name'],
      version: json['version'],
      authors: AuthorModel.toList(json['authors']),
      description: json['description'],
      shortDescription: json['shortDescription'],
      thumbnailUrl: json['thumbnailUrl'],
      publisher: PublisherModel.toList(json['publishers']),
      categories: CategoryModel.toList(json['categories']),
    );
  }

  Future<Map<int, List<dynamic>>> getBooks({int page, String bookName}) async {
    List<dynamic> books;
    var response = await PostApi.getBooks(page: page, bookName: bookName);
    if (response == null) return null;
    try {
      books = response.data
          .map((book) => new BookModel(
                id: book["id"],
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
