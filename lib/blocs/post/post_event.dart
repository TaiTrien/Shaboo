part of 'post_bloc.dart';

@immutable
abstract class PostEvent {
  final dynamic payload;

  PostEvent({this.payload});
}

class UpdateCurrentPost extends PostEvent {
  UpdateCurrentPost(PostModel currentPost) : super(payload: currentPost);
}

class AddPost extends PostEvent {
  AddPost(PostModel currentPost) : super(payload: currentPost);
}

class UpdatePost extends PostEvent {
  UpdatePost(PostModel selectedPost) : super(payload: selectedPost);
}

class ResetCurrentPost extends PostEvent {
  ResetCurrentPost(PostModel currentPost) : super(payload: currentPost);
}
