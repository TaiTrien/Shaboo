import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/constants/ui_constants.dart';

import 'package:shaboo/modules/auth/login/models/auth.dart';
import 'package:shaboo/modules/updateInfo/update_profile.dart';

class ProfileController {
  BuildContext context;
  // ignore: close_sinks
  UserBloc _userBloc;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebooklogin = FacebookLogin();
  final AuthModel _authModel = AuthModel();

  ProfileController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  Future<void> signOut() async {
    _authModel.signOut();
    Navigator.pushNamed(context, '/loginScreen');
  }

  onMenuSelect(value) {
    if (value == MenuValue.SIGNOUT)
      _alertSignOut();
    else
      toEditProfile();
  }

  toEditProfile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateProfile()));
  }

  Future<void> _alertSignOut() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                color: Colors.red[600],
                size: 30,
              ),
              SizedBox(width: 5),
              Text('Bạn sẽ đăng xuất?',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Huỷ bỏ',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                'Đồng ý',
                style: TextStyle(
                  color: Colors.red[600],
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              onPressed: signOut,
            ),
          ],
        );
      },
    );
  }

  get currentUser => _userBloc.state.currentUser;
  get userFullName =>
      _userBloc.state.currentUser.firstName.toUpperCase() +
      ' ' +
      _userBloc.state.currentUser.lastName.toUpperCase();
  get defaultAvatar => SvgPicture.asset('assets/images/reader.svg');
}
