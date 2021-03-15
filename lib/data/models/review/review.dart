import 'package:equatable/equatable.dart';
import 'package:shaboo/data/models/model.dart';

class ReviewModel extends Equatable implements Model {
  ReviewModel({
    int id,
    this.review,
    this.tags,
    this.score,
    this.bookId,
  }) : this._id = id;

  int _id;
  String review;
  String tags;
  int score;
  int bookId;

  //getters and setters
  set setReview(String review) => this.review = review;
  set setTags(String tags) => this.tags = tags;
  set setScore(int score) => this.score = score;
  set setBookId(int bookId) => this.bookId = bookId;

  get id => this._id;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        review: json["review"],
        tags: json["tags"],
        score: json["score"],
        bookId: json["bookId"],
      );

  Map<String, dynamic> toJson() => {
        "review": review,
        "tags": tags,
        "score": score,
        "bookId": bookId,
      };

  static List<ReviewModel> toList(List<dynamic> dynamicList) {
    List<ReviewModel> list = [];
    dynamicList?.forEach((item) {
      list.add(ReviewModel.fromJson(item));
    });
    return list;
  }

  @override
  List<Object> get props => [review, tags, score, bookId];
}

class ListReview {
  List<ReviewModel> listReview;
  int page, take;
  int itemCount, pageCount;

  ListReview({this.listReview, this.page, this.take, this.itemCount, this.pageCount});

  factory ListReview.fromJson(Map<String, dynamic> json) {
    return ListReview(
      take: json['meta']['take'],
      page: json['meta']['page'],
      itemCount: json['meta']['itemCount'],
      pageCount: json['meta']['pageCount'],
      listReview: ReviewModel.toList(json['data']),
    );
  }
}
