import 'package:shaboo/models/model.dart';
import 'package:shaboo/providers/remote/api/book_api.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/models/post/author.dart';
import 'package:shaboo/models/post/category.dart';
import 'package:shaboo/models/post/publisher.dart';

class BookModel implements Model {
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
  static List<BookModel> toList(List<dynamic> dynamicList) {
    List<BookModel> list = [];
    dynamicList?.forEach((item) {
      list.add(BookModel.fromJson(item));
    });
    return list;
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

  get id => this._id;
}

class ListBook {
  List<BookModel> listBook;
  int page, take;
  int itemCount, pageCount;

  ListBook({this.listBook, this.page, this.take, this.itemCount, this.pageCount});

  factory ListBook.fromJson(Map<String, dynamic> json) {
    return ListBook(
      take: json['meta']['take'],
      page: json['meta']['page'],
      itemCount: json['meta']['itemCount'],
      pageCount: json['meta']['pageCount'],
      listBook: BookModel.toList(json['data']),
    );
  }

  static Future<ListBook> getBooks({EOrder eOrder, int page, int take, String bookName}) async {
    final response = await BookApi.getBooks(eOrder: EOrder.ASC, page: page, bookName: bookName);
    return ListBook.fromJson(response);
  }

  static Future<ListBook> getRecommendBooks(EOrder eOrder, int page) async {
    final response = await BookApi.getRecommendBooks(eOrder: eOrder, page: page ?? 1);
    return ListBook.fromJson(response);
  }
}
