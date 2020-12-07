import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shaboo/model/response.dart';

import 'package:shaboo/utils/store.dart';

class PostApi {
  static String prefixUrl = 'http://192.168.137.1:3001';
  static String urlUploadPhoto = '$prefixUrl/images';
  static String urlFacebookSignin = '$prefixUrl/auth/facebook';

  static Future<dynamic> uploadPhoto({List<File> photos}) async {
    var token = await Store.getToken();
    var request = http.MultipartRequest('POST', Uri.parse(urlUploadPhoto));

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
    };
    request.headers.addAll(headers);

    for (var photo in photos) {
      request.files.add(await http.MultipartFile.fromPath('images', photo.path));
    }

    try {
      var response = await http.Response.fromStream(await request.send());

      int prefixStatusCode = response.statusCode ~/ 100;
      if (prefixStatusCode != 2) return null;

      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
