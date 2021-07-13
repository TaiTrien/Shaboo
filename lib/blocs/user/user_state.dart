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

class EditProcessing extends UserState {}

class EditFailed extends UserState {
  final String message;

  EditFailed(UserState oldState, {this.message})
      : super(currentUser: oldState.currentUser);
}

class EditSucceed extends UserState {
  EditSucceed(UserState oldState, {UserModel currentUser})
      : super(currentUser: currentUser ?? oldState.currentUser);
}

class UploadAvatarProcessing extends UserState {}

class UploadAvatarFailed extends UserState {
  final String message;

  UploadAvatarFailed(UserState oldState, {this.message})
      : super(currentUser: oldState.currentUser);
}

class UploadAvatarSuccess extends UserState {
  UploadAvatarSuccess(UserState oldState, {UserModel currentUser})
      : super(currentUser: currentUser ?? oldState.currentUser);
}

class ResetState extends UserState {
  ResetState() : super(currentUser: null);
}
