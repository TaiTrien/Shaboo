import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shaboo/model/response.dart';

class AuthApi {
  static String prefixUrl = 'http://192.168.137.1:3001';
  static String urlGoogleSignin = '$prefixUrl/auth/google';
  static String urlFacebookSignin = '$prefixUrl/auth/facebook';

  static Future<dynamic> signInByGoogle({String userID, String idToken}) async {
    try {
      var response = await http.post(
        urlGoogleSignin,
        body: {
          "userID": userID,
          "token": idToken,
        },
      );
      if (response.statusCode != 200) return null;
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
      if (response.statusCode != 200) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {}
  }
}

// static Future<dynamic> getRegisterResponse(
//     {String name, String userName, String password}) async {
//   var response = await http.post(
//     urlRegister,
//     body: {
//       "name": name,
//       "user_name": userName,
//       "password": password,
//     },
//   );
//   //var data = Response.map(json.decode(response.body));
//   //return data;
// }

//   static Future<dynamic> getUserInfo() async {
//     var token = await Store.getToken();
//     var response = await http.get(
//       urlGetUserInfo,
//       headers: {
//         "Authorization": token,
//       },
//     );
//     var data = Response.map(json.decode(response.body));
//     if (data.code != 200) {
//       return data.apiMessagse;
//     }
//     return data;
//   }

//   static Future<dynamic> changePassword(
//       {String currentPassword, String newPassword}) async {
//     var token = await Store.getToken();
//     var response = await http.put(
//       urlChangePassword,
//       headers: {
//         "Authorization": token,
//       },
//       body: {
//         "current_password": currentPassword,
//         "new_password": newPassword,
//       },
//     );
//     var data = Response.map(json.decode(response.body));
//     return data;
//   }
// }
