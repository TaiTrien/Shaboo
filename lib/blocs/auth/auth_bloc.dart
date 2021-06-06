import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shaboo/data/providers/remote/api/auth_api.dart';
import 'package:shaboo/utils/store.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is Login) {
      yield UpdateState(state, isLogging: event.payload);
    } else if (event is SignUp) {
      yield AuthLoadingState();
      var response = await AuthApi.signUp(
          email: event.payload['email'], password: event.payload['password']);
      if (response == null)
        yield SignUpFailedState(error: 'Đã có lỗi xảy ra');
      else {
        var token = response.token['accessToken'];
        Store.setToken(token);
        yield SignUpSuccessState();
      }
    }
  }
}
