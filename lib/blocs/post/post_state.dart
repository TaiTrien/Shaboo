part of 'post_bloc.dart';

enum Status { initial, loading, success, failure }

@immutable
abstract class PostState {
  final PostModel currentPost;

  PostState({this.currentPost});
}

class PostInitial extends PostState {
  PostInitial() : super(currentPost: null);
}

class UpdateState extends PostState {
  UpdateState(PostState oldState, {PostModel currentPost})
      : super(currentPost: currentPost ?? oldState.currentPost);
}

class PostProcessing extends PostState {}

class PostSucceed extends PostState {}

class UpdatePostSucceed extends PostState {}

class PostError extends PostState {
  final String error;
  PostError(PostState oldstate, {this.error})
      : super(currentPost: oldstate.currentPost);
}

class ResetState extends PostState {
  ResetState({PostModel currentPost}) : super(currentPost: currentPost);
}
