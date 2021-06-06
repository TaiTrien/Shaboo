part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  final dynamic payload;

  AuthEvent({this.payload});
}

class Login extends AuthEvent {
  Login(bool isLogging) : super(payload: isLogging);
}

class SignUp extends AuthEvent {
  SignUp({String email, String password})
      : super(payload: {"email": email, "password": password});
}
