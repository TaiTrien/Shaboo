import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lazyload_event.dart';
part 'lazyload_state.dart';

class LazyLoadBloc extends Bloc<LazyloadEvent, LazyLoadState> {
  final Future<dynamic> fetchData;
  LazyLoadBloc({this.fetchData}) : super(LazyloadInitial());

  @override
  Stream<LazyLoadState> mapEventToState(
    LazyloadEvent event,
  ) async* {
    try {
      if (event is LoadMore) {
        if (event.clearCachedData) {
          yield UpdateState(state, newData: []);
        }
        yield LoadingState();
        var newData = await fetchData;
        if (newData == null)
          yield ErrorState(errorMessage: "Something went wrong");
        else if (state.data != null) {
          if (state.data.listData.length >= newData.totalElement) yield NoMoreState();
        } else {
          if (state.data != null) newData.listData.addAll(state.data);
          yield UpdateState(state, newData: newData.listData);
        }
      }
    } catch (exception) {
      yield ErrorState(errorMessage: exception.toString());
    }
  }
}
