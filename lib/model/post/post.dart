import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/book.dart';
import 'package:shaboo/model/post/image.dart';

class PostModel {
  String title;
  String description;
  String status = "OPENED";
  String location;
  BookModel book;
  List<ImageModel> images;

  PostModel({
    this.title,
    this.description,
    this.status = "OPENED",
    this.location,
    this.book,
    this.images,
  });

  Future<dynamic> upload({PostModel post}) async {
    return await PostApi.uploadPost(post: post);
  }

  static converPostToMap({PostModel post}) {
    Map<String, dynamic> convertedPost = {
      "title": "${post.title}",
      "description": "${post.description}",
      "status": "${post.status}",
      "location": "${post.location}",
      "book": {
        "id": post.book.id,
        "name": "${post.book.name}",
        "version": post.book.version,
        "authors": post.book.authors
            .map((author) => {
                  "id": author["author"]["id"],
                  "name": "${author["author"]["name"]}",
                  "slug": "${author["author"]["slug"]}",
                })
            .toList(),
        "description": "${post.book.description}",
        "shortDescription": "${post.book.shortDescription}",
        "thumbnailUrl": "${post.book.thumbnailUrl}",
        "publisher": post.book.publisher
            .map((publisher) => {
                  "id": publisher["publisher"]["id"],
                  "name": "${publisher["publisher"]["name"]}",
                  "slug": "${publisher["publisher"]["slug"]}",
                })
            .toList(),
        "categories": post.book.categories.map((category) => category["category"]["id"]).toList(),
      },
      "images": post.images.map((image) => image.imageID).toList(),
    };

    return convertedPost;
  }

  set setTitle(String title) => this.title = title;
  set setDesc(String desc) => this.description = desc;
  set setLocation(String location) => this.location = location;
  set setBook(BookModel selectedBook) => this.book = selectedBook;
  set setImages(List<ImageModel> images) => this.images = images;

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'desc': this.description,
        'status': this.status,
        'location': this.location,
        'book': this.book,
        'images': this.images,
      };
}
