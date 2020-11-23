part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final isLogging;

  AuthState({this.isLogging});
}

class AuthInitial extends AuthState {
  AuthInitial() : super(isLogging: false);
}

class UpdateState extends AuthState {
  UpdateState(
    AuthState oldState, {
    bool isLogging,
  }) : super(isLogging: isLogging ?? oldState.isLogging);
}
