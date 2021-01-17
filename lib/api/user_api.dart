import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/constants.dart';
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
}
