part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final User currentUser;

  UserState({this.currentUser});
}

class UserInitial extends UserState {
  UserInitial() : super(currentUser: null);
}

class UpdateState extends UserState {
  UpdateState(
    UserState oldState, {
    User currentUser,
  }) : super(currentUser: currentUser ?? oldState.currentUser);
}
