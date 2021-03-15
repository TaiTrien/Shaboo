part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState({this.currentReview});
  final ReviewModel currentReview;
  @override
  List<Object> get props => [currentReview];
}

class ReviewInitialState extends ReviewState {}

class ReviewLoadingState extends ReviewState {}

class ReviewSuccessState extends ReviewState {}

class ReviewErrorState extends ReviewState {
  final String message;
  ReviewErrorState({this.message});
}

class UpdateCurrentReviewState extends ReviewState {
  UpdateCurrentReviewState(ReviewState oldState, {ReviewModel currentReview})
      : super(currentReview: currentReview ?? oldState.currentReview);
}
