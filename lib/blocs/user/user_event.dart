part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  final dynamic payload;

  UserEvent({this.payload});
}

class LoadUserData extends UserEvent {
  LoadUserData(User currentUser) : super(payload: currentUser);
}
