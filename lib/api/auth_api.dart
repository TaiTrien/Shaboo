import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shaboo/model/response.dart';

class UserApi {
  static String prefixUrl = 'http://10.0.2.2:3001';
  static String urlGoogleLogin = '$prefixUrl/auth/google';
  static String urlRegister = "https://fin.mal.vn/api/user/register";
  static String urlGetUserInfo = 'https://fin.mal.vn/api/user/info';
  static String urlChangePassword =
      'https://fin.mal.vn/api/user/password_change';

  static Future<String> getUserTokenThroughGoogle(
      {String googleID, String googleToken}) async {
    String token;

    var response = await http.post(
      urlGoogleLogin,
      body: {
        "user_name": googleID,
        "password": googleToken,
      },
    );
    if (response.statusCode != 200) return null;

    token = Response.map(json.decode(response.body)).data;
    return token;
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
