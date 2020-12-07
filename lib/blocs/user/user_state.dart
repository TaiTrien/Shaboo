part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final UserModel currentUser;

  UserState({this.currentUser});
}

class UserInitial extends UserState {
  UserInitial() : super(currentUser: null);
}

class UpdateState extends UserState {
  UpdateState(
    UserState oldState, {
    UserModel currentUser,
  }) : super(currentUser: currentUser ?? oldState.currentUser);
}
