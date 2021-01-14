import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/book.dart';

class PostModel {
  String title;
  String desc;
  PostStatus status;
  String location;
  BookModel book;
  List<String> images;

  PostModel({
    this.title,
    this.desc,
    this.status,
    this.location,
    this.book,
    this.images,
  });

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'desc': this.desc,
        'status': this.status,
        'location': this.location,
        'book': this.book.bookName,
        'images': this.images,
      };
}
