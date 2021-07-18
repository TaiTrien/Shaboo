import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shaboo/constants/api_constants.dart';

import 'package:shaboo/data/models/response/response.dart';
import 'package:shaboo/data/models/user/user.dart';
import 'package:shaboo/utils/formatter.dart';
import 'package:shaboo/utils/store.dart';

class UserApi {
  static String urlUsers = '$kPrefixUrl/users';
  static String urlGetMyProfile = '$kPrefixUrl/auth/me';
  static String urlUploadAvatar = '$kPrefixUrl/users/avatar';

  static getHeader() async => {
        "Authorization": "Bearer ${await Store.getToken()}",
        "Content-Type": "application/json",
      };

  static Future<dynamic> getMyProfile() async {
    try {
      var response = await http.get(
        Uri.parse('$urlGetMyProfile'),
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getUserById(String id) async {
    try {
      var response = await http.get(
        Uri.parse('$urlUsers/$id'),
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> editInfo({UserModel currentUser}) async {
    // var requestedUser = UserModel().toJson(data: currentUser);
    // print(json.encode(currentUser.categories.map((cate) => cate?.categoryID)?.toList()));
    var categoriesId = [];
    for (var e in currentUser.categories) {
      categoriesId.add(e.categoryID);
    }
    print(categoriesId);
    try {
      var response = await http.put(
        Uri.parse('$urlUsers'),
        headers: await getHeader(),
        body: json.encode({
          "firstName": currentUser.firstName,
          "lastName": currentUser.lastName,
          "email": currentUser.email,
          "phone": currentUser.phone,
          "gender": "MALE",
          "birth": currentUser.birthday ?? Formatter.formatDataForUpdate(date: DateTime.now()),
          "facebook": currentUser.facebook != null ? currentUser.facebook : '',
          "categories": categoriesId,
        }),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> uploadAvatar({File avatar}) async {
    var request = http.MultipartRequest('PUT', Uri.parse(urlUploadAvatar));

    Map<String, String> headers = await getHeader();
    request.headers.addAll(headers);

    request.files.add(await http.MultipartFile.fromPath('image', avatar.path));

    try {
      var response = await http.Response.fromStream(await request.send());

      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
