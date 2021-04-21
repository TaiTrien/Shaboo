part of 'simpleload_bloc.dart';

abstract class SimpleLoadState {
  final dynamic data;

  SimpleLoadState({this.data});
}

class SimpleLoadInitial extends SimpleLoadState {
  SimpleLoadInitial() : super(data: null);
}

class LoadingState extends SimpleLoadState {
  LoadingState(SimpleLoadState oldState) : super(data: oldState.data ?? null);
}

class ErrorState extends SimpleLoadState {
  final String errorMessage;
  ErrorState(SimpleLoadState oldState, {this.errorMessage}) : super(data: oldState.data ?? null);
}

class UpdateState extends SimpleLoadState {
  final dynamic newData;

  UpdateState(SimpleLoadState oldState, {this.newData}) : super(data: newData ?? oldState.data);
}
