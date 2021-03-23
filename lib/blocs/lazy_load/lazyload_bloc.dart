import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lazyload_event.dart';
part 'lazyload_state.dart';

class LazyloadBloc extends Bloc<LazyloadEvent, LazyloadState> {
  final Future<dynamic> fetchData;
  LazyloadBloc({this.fetchData}) : super(LazyloadInitial());

  @override
  Stream<LazyloadState> mapEventToState(
    LazyloadEvent event,
  ) async* {
    try {
      if (event is Refresh) {
        yield UpdateState(state, newData: []);
        yield LoadingState();

        var newData = await fetchData;
        if (newData == null)
          yield ErrorState(errorMessage: "Đã xảy ra lỗi");
        else if (newData.isEmpty)
          yield NoMoreState();
        else
          yield UpdateState(state, newData: newData);
      } else if (event is LoadMore) {
        yield LoadingState();

        var newData = await fetchData;
        if (newData == null)
          yield ErrorState(errorMessage: "Đã xảy ra lỗi");
        else if (newData.isEmpty)
          yield NoMoreState();
        else {
          newData.addAll(state.data);
          yield UpdateState(state, newData: newData);
        }
      }
    } catch (exception) {
      yield ErrorState(errorMessage: exception.toString());
    }
  }
}
