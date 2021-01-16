import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/api/post_api.dart';
import 'package:shaboo/model/post/book.dart';
import 'package:shaboo/model/post/image.dart';

class PostModel {
  String title;
  String description;
  String range;
  String status = "OPENED";
  String location;
  BookModel book;
  String id;
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
        "categories": post.book.categories
            .map((category) => category["category"]["id"])
            .toList(),
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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final postModel = PostModel(
      title: json['title'],
      description: json['description'],
      status: json['status'],
      location: json['location'],
      book: BookModel.fromJson(json['book']),
      images: ImageModel.toList(json['images']),
    );
    return postModel;
  }

  static List<PostModel> toList(List<dynamic> dynamicList) {
    List<PostModel> list = [];
    dynamicList.forEach((item) {
      list.add(PostModel.fromJson(item));
    });
    return list;
  }
}

class ListPost {
  List<PostModel> listPost;
  int page, take;
  int itemCount, pageCount;

  ListPost(
      {this.listPost, this.page, this.take, this.itemCount, this.pageCount});

  factory ListPost.fromJson(Map<String, dynamic> json) {
    return ListPost(
      take: json['meta']['take'],
      page: json['meta']['page'],
      itemCount: json['meta']['itemCount'],
      pageCount: json['meta']['pageCount'],
      listPost: PostModel.toList(json['data']),
    );
  }

  static Future<ListPost> getPosts(EOrder eOrder, int page, int take) async {
    final response = await PostApi.getPosts(eOrder, page, take);
    return ListPost.fromJson(response);
  }
}
