import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shaboo/data/models/response/response.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/utils/formatter.dart';

class AuthApi {
  static String urlGoogleSignin = '$kPrefixUrl/auth/google';
  static String urlFacebookSignin = '$kPrefixUrl/auth/facebook';
  static String urlSignUp = '$kPrefixUrl/auth/register';
  static String urlSignIn = '$kPrefixUrl/auth/login';

  static Future<dynamic> signInByGoogle({String userID, String idToken}) async {
    try {
      var response = await http.post(
        Uri.parse(urlGoogleSignin),
        body: {
          "userID": userID,
          "token": idToken,
        },
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> signInByFacebook({String userID, String idToken}) async {
    try {
      var response = await http.post(
        Uri.parse(urlFacebookSignin),
        body: {
          "userID": userID,
          "token": idToken,
        },
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {}
  }

  static Future<dynamic> signUp({String email, String password}) async {
    try {
      var defaultDOB = Formatter.formatDateSignUp(date: DateTime.now());
      var response = await http.post(
        Uri.parse(urlSignUp),
        body: {
          "firstName": "",
          "lastName": "",
          "password": password,
          "role": "USER",
          "gender": "MALE",
          "birth": defaultDOB,
          "username": email,
        },
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> signIn({String email, String password}) async {
    try {
      var response = await http.post(
        Uri.parse(urlSignIn),
        body: {"username": email, "facebookID": "", "googleID": "", "facebookToken": "", "googleToken": "", "password": password},
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
