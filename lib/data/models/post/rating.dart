import 'dart:convert';

RatingModel ratingModelFromJson(String str) =>
    RatingModel.fromJson(json.decode(str));

String ratingModelToJson(RatingModel data) => json.encode(data.toJson());

class RatingModel {
  RatingModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.ratingCount,
    this.totalScore,
    this.finalScore,
    this.bookId,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int ratingCount;
  double totalScore;
  double finalScore;
  int bookId;

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        ratingCount: json["ratingCount"],
        totalScore: double.tryParse(json["totalScore"].toString()),
        finalScore: double.tryParse(json["finalScore"].toString()),
        bookId: json["bookId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "ratingCount": ratingCount,
        "totalScore": totalScore,
        "finalScore": finalScore,
        "bookId": bookId,
      };
}
