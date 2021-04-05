import 'dart:async';

import 'package:bloc/bloc.dart';

part 'lazyload_event.dart';
part 'lazyload_state.dart';

class LazyLoadBloc extends Bloc<LazyloadEvent, LazyLoadState> {
  LazyLoadBloc() : super(LazyloadInitial());

  @override
  Stream<LazyLoadState> mapEventToState(
    LazyloadEvent event,
  ) async* {
    try {
      if (event is LoadMore) {
        if (event.clearCachedData) {
          yield UpdateState(state, newData: [], totalElement: 0);
          yield LoadingState(state);
          var newData = await event.fetchData;
          yield UpdateState(state, newData: newData.listData, totalElement: newData.totalElement);
        } else if (!event.clearCachedData) {
          if (state.data.length >= state.totalElement)
            yield NoMoreState(state);
          else if (state.data.length <= state.totalElement) {
            yield HasMoreState(state);
            var newData = await event.fetchData;
            if (newData == null)
              yield ErrorState(state, errorMessage: "Something went wrong");
            else if (newData != null) {
              state.data.addAll(newData.listData);
              yield UpdateState(state, newData: state.data);
            }
          }
        }
      }
    } catch (exception) {
      yield ErrorState(state, errorMessage: exception.toString());
    }
  }
}
