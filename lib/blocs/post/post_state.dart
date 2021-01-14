part of 'post_bloc.dart';

@immutable
abstract class PostState {
  final PostModel currentPost;

  PostState({this.currentPost});
}

class PostInitial extends PostState {
  PostInitial() : super(currentPost: null);
}

class UpdateState extends PostState {
  UpdateState(PostState oldState, {PostModel currentPost}) : super(currentPost: currentPost ?? oldState.currentPost);
}
