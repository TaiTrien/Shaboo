import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shaboo/model/response.dart';

import 'package:shaboo/utils/store.dart';

class PostApi {
  static String prefixUrl = 'http://192.168.30.201:3001';
  static String urlUploadPhoto = '$prefixUrl/images';
  static String urlFacebookSignin = '$prefixUrl/auth/facebook';

  static Future<dynamic> uploadPhoto({File image}) async {
    var token = await Store.getToken();
    var request = http.MultipartRequest('POST', Uri.parse(urlUploadPhoto));

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
    };
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('images', image.path));

    var response = await http.Response.fromStream(await request.send());

    int prefixStatusCode = response.statusCode ~/ 100;
    if (prefixStatusCode != 2) return null;

    return Response.map(json.decode(response.body));
  }
}
