part of 'lazyload_bloc.dart';

abstract class LazyLoadState extends Equatable {
  final dynamic data;

  LazyLoadState({this.data});
  @override
  List<Object> get props => [data];
}

class LazyloadInitial extends LazyLoadState {
  LazyloadInitial() : super(data: []);
}

class LoadingState extends LazyLoadState {}

class NoMoreState extends LazyLoadState {}

class ErrorState extends LazyLoadState {
  final String errorMessage;
  ErrorState({this.errorMessage});
}

class SuccessfulState extends LazyLoadState {}

class UpdateState extends LazyLoadState {
  final dynamic newData;
  final int numberOfItems;

  UpdateState(LazyLoadState oldState, {this.newData, this.numberOfItems}) : super(data: newData ?? oldState.data);
}
