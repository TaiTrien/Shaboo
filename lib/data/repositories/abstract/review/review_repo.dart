import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/data/models/review/review.dart';

abstract class ReviewReposity {
  Future<dynamic> addReview({ReviewModel review});

  Future<dynamic> editReview({ReviewModel review});

  Future<dynamic> getReviews({EOrder eOrder, int page, String bookId});

  Future<dynamic> deleteReview({int reviewId});
}
