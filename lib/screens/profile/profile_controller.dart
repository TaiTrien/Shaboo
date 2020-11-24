import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/utils/store.dart';

enum MenuValue {
  SETTINGS,
  SIGNOUT,
}

class ProfileController {
  BuildContext context;
  UserBloc _userBloc;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebooklogin = FacebookLogin();

  ProfileController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }

  Future<void> signOutFacebook() async {
    await facebooklogin.logOut();
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
              Text('Are you sure to sign out ?'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                'Sign out',
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

  Future<void> signOut() async {
    signOutGoogle();
    signOutFacebook();
    Store.deleteToken();
    Navigator.pushNamed(context, '/loginScreen');
  }

  onMenuSelect(value) {
    if (value == MenuValue.SIGNOUT) _alertSignOut();
  }

  get currentUser => _userBloc.state.currentUser;
  get userFullName =>
      _userBloc.state.currentUser.firstName.toUpperCase() +
      ' ' +
      _userBloc.state.currentUser.lastName.toUpperCase();
  get defaultAvatar => SvgPicture.asset('assets/images/reader.svg');
}
