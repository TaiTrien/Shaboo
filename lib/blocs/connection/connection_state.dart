part of 'connection_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetError extends InternetState {
  final String message;

  InternetError({@required this.message});
}

class InternetConnected extends InternetState {}

class InternetDisconnected extends InternetState {}
