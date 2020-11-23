part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final ShabooUser currentUser;

  UserState({this.currentUser});
}

class UserInitial extends UserState {
  UserInitial() : super(currentUser: null);
}

class UpdateState extends UserState {
  UpdateState(
    UserState oldState, {
    ShabooUser currentUser,
  }) : super(currentUser: currentUser ?? oldState.currentUser);
}
