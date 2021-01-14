part of 'post_bloc.dart';

@immutable
abstract class PostEvent {
  final dynamic payload;

  PostEvent({this.payload});
}

class UpdateCurrentPost extends PostEvent {
  UpdateCurrentPost(PostModel currentPost) : super(payload: currentPost);
}
