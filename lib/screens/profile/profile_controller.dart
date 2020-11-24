import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';

class ProfileController {
  BuildContext context;
  UserBloc _userBloc;

  ProfileController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
  }
// Future<void> signOutGoogle() async {
//     await googleSignIn.disconnect();
//     await googleSignIn.signOut();
//     await _auth.signOut();
//     Navigator.pushNamed(context, '/loginScreen');
//   }
  onMenuSelect(value) {
    print(value);
  }

  get currentUser => _userBloc.state.currentUser;
  get userFullName =>
      _userBloc.state.currentUser.firstName.toUpperCase() +
      ' ' +
      _userBloc.state.currentUser.lastName.toUpperCase();
  get defaultAvatar => SvgPicture.asset('assets/images/reader.svg');
}
