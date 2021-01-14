import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/book.dart';
import 'package:shaboo/model/post/image.dart';

class PostModel {
  String title;
  String desc;
  PostStatus status;
  String location;
  BookModel book;
  List<ImageModel> images;

  PostModel({
    this.title,
    this.desc,
    this.status,
    this.location,
    this.book,
    this.images,
  });

  set setTitle(String title) => this.title = title;
  set setDesc(String desc) => this.desc = desc;
  set setLocation(String location) => this.location = location;
  set setBook(BookModel selectedBook) => this.book = selectedBook;
  set setImages(List<ImageModel> images) => this.images = images;

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'desc': this.desc,
        'status': this.status,
        'location': this.location,
        'book': this.book.bookName,
        'images': this.images,
      };
}
