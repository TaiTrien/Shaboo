import 'dart:async';

import 'package:bloc/bloc.dart';

part 'simpleload_event.dart';
part 'simpleload_state.dart';

class SimpleLoadBloc extends Bloc<SimpleLoadEvent, SimpleLoadState> {
  final dynamic fetchData;
  SimpleLoadBloc({this.fetchData}) : super(SimpleLoadInitial());

  @override
  Stream<SimpleLoadState> mapEventToState(
    SimpleLoadEvent event,
  ) async* {
    if (event is LoadData) {
      yield LoadingState(state);
      var newData = await fetchData;
      if (newData == null)
        yield ErrorState(state, errorMessage: "Something went wrong");
      else if (newData != null) {
        yield UpdateState(state, newData: newData);
      }
    }
  }
}
