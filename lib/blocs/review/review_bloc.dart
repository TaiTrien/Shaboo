import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/data/repositories/implement/review/review_repo_impl.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepoImpl reviewRepo;
  ReviewBloc({@required this.reviewRepo}) : super(ReviewInitialState());

  @override
  Stream<ReviewState> mapEventToState(
    ReviewEvent event,
  ) async* {
    if (event is AddReview) {
      yield ReviewLoadingState();
      try {
        var result = await reviewRepo.addReview(review: event.payload);
        if (result == null)
          yield ReviewErrorState(message: 'Đã có lỗi xảy ra');
        else
          yield ReviewSuccessState();
      } catch (e) {
        yield ReviewErrorState(message: e.toString());
      }
    } else if (event is EditReview) {
      yield ReviewLoadingState();
      try {
        var result = await reviewRepo.editReview(review: event.payload);
        if (result != null && successCodes.contains(result['status'])) {
          yield ReviewSuccessState();
        } else
          yield ReviewErrorState(message: 'Đã có lỗi xảy ra');
      } catch (e) {
        yield ReviewErrorState(message: e.toString());
      }
    } else if (event is DeleteReview) {
      yield ReviewLoadingState();
      try {
        var result = await reviewRepo.deleteReview(reviewId: event.payload.id);
        if (state.currentReview == null || result == null)
          yield ReviewErrorState(message: 'Đã có lỗi xảy ra');
        else
          yield ReviewSuccessState();
      } catch (e) {
        yield ReviewErrorState(message: e);
      }
    } else if (event is UpdateCurrentReview) {
      try {
        yield UpdateCurrentReviewState(state, currentReview: event.payload);
      } catch (e) {
        yield ReviewErrorState(message: e);
      }
    }
  }
}
