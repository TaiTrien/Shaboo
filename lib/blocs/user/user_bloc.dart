import 'dart:async';

import "package:bloc/bloc.dart";
import 'package:meta/meta.dart';
import 'package:shaboo/shared_models/user/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UpdateUserData) {
      yield UpdateState(state, currentUser: event.payload);
    }
  }
}
