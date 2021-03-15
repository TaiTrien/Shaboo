part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  final dynamic payload;

  const ReviewEvent({this.payload});

  @override
  List<Object> get props => [payload];
}

class UpdateCurrentReview extends ReviewEvent {
  UpdateCurrentReview(ReviewModel currentReview) : super(payload: currentReview);
}

class AddReview extends ReviewEvent {
  AddReview(ReviewModel currentReview) : super(payload: currentReview);
}

class EditReview extends ReviewEvent {
  EditReview(ReviewModel currentReview) : super(payload: currentReview);
}

class DeleteReview extends ReviewEvent {
  DeleteReview(ReviewModel currentReview) : super(payload: currentReview);
}
