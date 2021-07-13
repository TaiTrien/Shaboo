import 'dart:async';
import 'dart:io';

import "package:bloc/bloc.dart";
import 'package:meta/meta.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/data/models/response/response.dart';
import 'package:shaboo/data/models/user/user.dart';
import 'package:shaboo/data/repositories/implement/user/user_repo_impl.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepoImpl userRepo;

  UserBloc({@required this.userRepo}) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UpdateUserData) {
      yield UpdateState(state, currentUser: event.payload);
    } else if (event is EditUserInfo) {
      yield EditProcessing();
      Response res = await userRepo.updateProfile(user: event.payload);
      yield UpdateState(state, currentUser: event.payload);
      if (!successCodes.contains(res?.statusCode))
        yield EditFailed(state, message: res?.apiMessagse);
      else if (res == null)
        yield EditFailed(state, message: 'Đã xảy ra lỗi');
      else {
        yield EditSucceed(state);
      }
    } else if (event is UploadAvatar) {
      yield UploadAvatarProcessing();
      Response res = await userRepo.uploadAvatar(avatar: event.payload);
      print(res);
      // yield UpdateState(state, currentUser: event.payload);
      // if (!successCodes.contains(res?.statusCode))
      //   yield EditFailed(state, message: res?.apiMessagse);
      // else if (res == null)
      //   yield EditFailed(state, message: 'Đã xảy ra lỗi');
      // else {
      //   yield EditSucceed(state);
      // }
    } else if (event is Reset) {
      yield ResetState();
    }
  }
}
