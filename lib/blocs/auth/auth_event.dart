part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  final dynamic payload;

  AuthEvent({this.payload});
}
