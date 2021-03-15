import 'package:shaboo/data/providers/remote/api/review_api.dart';
import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/data/repositories/abstract/review/review_repo.dart';

class ReviewRepoImpl implements ReviewReposity {
  @override
  Future<dynamic> addReview({ReviewModel review}) async {
    var response = await ReviewApi.postReview(review: review);
    if (response != null) return ReviewModel.fromJson(response["data"]);
    return null;
  }

  @override
  Future<dynamic> editReview({ReviewModel review}) async {
    var response = await ReviewApi.editReview(review: review);
    if (response != null) return ReviewModel.fromJson(response["data"]);
    return null;
  }

  @override
  Future<dynamic> deleteReview({int reviewId}) async {
    var response = await ReviewApi.deleteReview(reviewId: reviewId);
    if (response != null) return ReviewModel.fromJson(response["data"]);
    return null;
  }

  @override
  Future<List> getReviews({EOrder eOrder, int page, String bookId}) {
    // TODO: implement getReviews
    throw UnimplementedError();
  }
}
