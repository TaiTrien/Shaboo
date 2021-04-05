part of 'lazyload_bloc.dart';

abstract class LazyLoadState {
  final dynamic data;
  final int totalElement;

  LazyLoadState({this.data, this.totalElement});
}

class LazyloadInitial extends LazyLoadState {
  LazyloadInitial() : super(data: [], totalElement: 0);
}

class LoadingState extends LazyLoadState {
  LoadingState(LazyLoadState oldState) : super(data: oldState.data ?? [], totalElement: oldState.totalElement);
}

class NoMoreState extends LazyLoadState {
  NoMoreState(LazyLoadState oldState) : super(data: oldState.data ?? [], totalElement: oldState.totalElement);
}

class HasMoreState extends LazyLoadState {
  HasMoreState(LazyLoadState oldState) : super(data: oldState.data ?? [], totalElement: oldState.totalElement);
}

class ErrorState extends LazyLoadState {
  final String errorMessage;
  ErrorState(LazyLoadState oldState, {this.errorMessage})
      : super(data: oldState.data ?? [], totalElement: oldState.totalElement);
}

class SuccessfulState extends LazyLoadState {
  SuccessfulState(LazyLoadState oldState) : super(data: oldState.data ?? [], totalElement: oldState.totalElement);
}

class UpdateState extends LazyLoadState {
  UpdateState(LazyLoadState oldState, {dynamic newData, int totalElement})
      : super(data: newData ?? oldState.data, totalElement: totalElement ?? oldState.totalElement);
}
