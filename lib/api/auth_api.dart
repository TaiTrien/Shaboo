import 'package:http/http.dart' as http;
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/constants.dart';
import 'dart:convert';

import 'package:shaboo/model/response.dart';

class AuthApi {
  static String urlGoogleSignin = '$kPrefixUrl/auth/google';
  static String urlFacebookSignin = '$kPrefixUrl/auth/facebook';

  static Future<dynamic> signInByGoogle({String userID, String idToken}) async {
    try {
      var response = await http.post(
        urlGoogleSignin,
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
        urlFacebookSignin,
        body: {
          "userID": userID,
          "token": idToken,
        },
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {}
  }
}
