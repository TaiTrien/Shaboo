part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final isLogging;

  AuthState({this.isLogging});
}

class AuthInitial extends AuthState {
  AuthInitial() : super(isLogging: false);
}

class AuthLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpFailedState extends AuthState {
  final String error;
  SignUpFailedState({this.error});
}

class UpdateState extends AuthState {
  UpdateState(
    AuthState oldState, {
    bool isLogging,
  }) : super(isLogging: isLogging ?? oldState.isLogging);
}
