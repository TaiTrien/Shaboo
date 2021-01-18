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
  int id;
  String userId;
  List<ImageModel> images;
  PostModel({
    this.title,
    this.userId,
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
                  "id": author.authorID,
                  "name": author.name,
                  "slug": author.slug,
                })
            .toList(),
        "description": "${post.book.description}",
        "shortDescription": "${post.book.shortDescription}",
        "thumbnailUrl": "${post.book.thumbnailUrl}",
        "publisher": post.book.publisher
            .map((publisher) => {
                  "id": publisher.publisherID,
                  "name": publisher.name,
                  "slug": publisher.slug,
                })
            .toList(),
        "categories": post.book.categories.map((category) => category.categoryID).toList(),
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
      userId: json['userId'].toString(),
      book: BookModel.fromJson(json['book']),
      images: ImageModel.toList(json['images']),
    );
    postModel.id = json['id'];
    return postModel;
  }

  static List<PostModel> toList(List<dynamic> dynamicList) {
    List<PostModel> list = [];
    dynamicList.forEach((item) {
      list.add(PostModel.fromJson(item));
    });
    return list;
  }

  static getPost(int id) async {
    final response = await PostApi.getPostById(id);
    return PostModel.fromJson(response['data']);
  }
}

class ListPost {
  List<PostModel> listPost;
  int page, take;
  int itemCount, pageCount;

  ListPost({this.listPost, this.page, this.take, this.itemCount, this.pageCount});

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
