import 'dart:io';

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
  Future<dynamic> getReviews({EOrder eOrder, int page, String bookId, String userId}) async {
    var response = await ReviewApi.getReviews(
        eOrder: eOrder ?? EOrder.ASC, page: page ?? 1, bookId: bookId ?? '', userId: userId ?? '');
    if (response != null)
      return ListReview.fromJson(response);
    else if (response == null) throw Exception('Fetching data error');
  }
}
