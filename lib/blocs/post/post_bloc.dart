import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shaboo/blocs/lazy_load/lazyload_bloc.dart';
import 'package:shaboo/data/models/post/post.dart';
import 'package:shaboo/data/repositories/implement/post/post_repo_impl.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepoImpl postRepo;
  PostBloc({this.postRepo}) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is UpdateCurrentPost) {
      yield UpdateState(state, currentPost: event.payload);
    } else if (event is ResetCurrentPost) {
      yield ResetState(currentPost: event.payload);
    } else if (event is AddPost) {
      yield PostProcessing();
      try {
        var result = await postRepo.addPost(post: event.payload);
        if (result == null)
          yield PostError(state, error: 'Đã có lỗi xảy ra');
        else
          yield PostSucceed();
      } catch (e) {
        yield PostError(state, error: e.toString());
      }
    } else if (event is UpdatePost) {
      //TODO: update post logic here
    }
  }
}
