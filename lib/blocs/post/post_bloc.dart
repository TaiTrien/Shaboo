import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shaboo/models/post/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is UpdateCurrentPost) {
      yield UpdateState(state, currentPost: event.payload);
    } else if (event is ResetCurrentPost) {
      yield ResetState(currentPost: event.payload);
    }
  }
}
