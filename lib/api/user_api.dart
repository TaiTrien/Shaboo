import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/response.dart';
import 'package:shaboo/model/user/user.dart';
import 'package:shaboo/utils/store.dart';

class UserApi {
  static String urlUsers = '$kPrefixUrl/users';
  static getHeader() async => {
        "Authorization": "Bearer ${await Store.getToken()}",
        "Content-Type": "application/json",
      };

  static Future<dynamic> getUserById(String id) async {
    try {
      var response = await http.get(
        '$urlUsers/$id',
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> editInfo({UserModel currentUser}) async {
    //TODO: fix data here to dynamic
    var requestedUser = {
      "firstName": currentUser.firstName,
      "lastName": currentUser.lastName,
      "email": currentUser.email,
      "phone": "0906839130",
      "gender": "MALE",
      "birth": "1999-05-28",
      "facebook": "https://www.facebook.com/taitrien99/",
      "categories": currentUser.categories.map((category) => category.categoryID).toList(),
    };
    try {
      var response = await http.put(
        '$urlUsers',
        headers: await getHeader(),
        body: json.encode(requestedUser),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
