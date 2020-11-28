import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shaboo/api/auth_api.dart';
import 'package:shaboo/model/user.dart';
import 'package:shaboo/utils/store.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebooklogin = FacebookLogin();

  Future<dynamic> googleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      var idToken = googleSignInAuthentication.idToken;
      var uid = googleSignInAccount.id;
      if (idToken == null || uid == null) return;

      var respone = await AuthApi.signInByGoogle(userID: uid, idToken: idToken);
      if (respone == null) return null;

      var token = respone.token["accessToken"];
      Store.setToken(token);

      var userData = respone.data;
      ShabooUser currentUser = new ShabooUser(
        userID: userData["id"],
        firstName: userData["firstName"],
        lastName: userData["lastName"],
        userName: userData["username"],
        email: userData["email"],
        phone: userData["phone"],
        avatar: userData["avatar"],
      );
      return currentUser;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> facebookSignIn() async {
    _facebooklogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    try {
      final result = await _facebooklogin.logIn(['email']);

      var uid = result.accessToken.userId;
      var idToken = result.accessToken.token;
      if (idToken == null || uid == null) return;

      var respone = await AuthApi.signInByFacebook(userID: uid, idToken: idToken);
      if (respone == null) return null;

      var token = respone.token["accessToken"];
      Store.setToken(token);

      var userData = respone.data;
      ShabooUser currentUser = new ShabooUser(
        userID: userData["id"],
        firstName: userData["firstName"],
        lastName: userData["lastName"],
        userName: userData["username"],
        email: userData["email"],
        phone: userData["phone"],
        avatar: userData["avatar"],
      );
      return currentUser;
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _facebooklogin.logOut();
    Store.deleteToken();
  }
}
