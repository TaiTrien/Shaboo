part of 'lazyload_bloc.dart';

abstract class LazyloadEvent {
  const LazyloadEvent();
}

class Refresh extends LazyloadEvent {}

class LoadMore extends LazyloadEvent {
  final bool clearCachedData;
  final dynamic fetchData;

  LoadMore({this.clearCachedData = false, this.fetchData});
}
