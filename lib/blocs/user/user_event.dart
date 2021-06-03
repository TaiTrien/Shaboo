part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  final dynamic payload;

  UserEvent({this.payload});
}

class UpdateUserData extends UserEvent {
  UpdateUserData(UserModel currentUser) : super(payload: currentUser);
}

class EditUserInfo extends UserEvent {
  EditUserInfo(UserModel data) : super(payload: data);
}
