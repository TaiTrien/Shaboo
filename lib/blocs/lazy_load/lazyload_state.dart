part of 'lazyload_bloc.dart';

abstract class LazyloadState extends Equatable {
  final List<dynamic> data;

  LazyloadState({this.data});
  @override
  List<Object> get props => [];
}

class LazyloadInitial extends LazyloadState {
  LazyloadInitial() : super(data: []);
}

class LoadingState extends LazyloadState {}

class NoMoreState extends LazyloadState {}

class ErrorState extends LazyloadState {
  final String errorMessage;
  ErrorState({this.errorMessage});
}

class UpdateState extends LazyloadState {
  final dynamic newData;

  UpdateState(LazyloadState oldState, {this.newData}) : super(data: newData ?? oldState.data);
}
