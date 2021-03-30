part of 'lazyload_bloc.dart';

abstract class LazyloadEvent extends Equatable {
  const LazyloadEvent();

  @override
  List<Object> get props => [];
}

class Refresh extends LazyloadEvent {}

class LoadMore extends LazyloadEvent {
  final bool clearCachedData;

  LoadMore({this.clearCachedData = false});
}
