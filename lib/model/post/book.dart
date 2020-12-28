import 'dart:core';

import 'package:shaboo/model/post/author.dart';
import 'package:shaboo/model/post/category.dart';
import 'package:shaboo/model/post/publisher.dart';

class BookModel {
  int _id;
  String createdAt;
  String updatedAt;
  String bookName;
  String version;
  String desc;
  String shortDesc;
  String thumbnailUrl;
  List<AuthorModel> authors;
  List<CategoryModel> categories;
  List<PublisherModel> publishers;

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
