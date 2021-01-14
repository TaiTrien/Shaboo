import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shaboo/model/response.dart';

import 'package:shaboo/utils/store.dart';

class PostApi {
  static String prefixUrl = 'http://10.0.128.70:3001';
  static String urlUploadPhoto = '$prefixUrl/images';
  static String urlFacebookSignin = '$prefixUrl/auth/facebook';
  static String urlGetBooks = '$prefixUrl/books?order=ASC';

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

  static Future<dynamic> getBooks({int page, String bookName}) async {
    var token = await Store.getToken();

    try {
      var response = await http.get(
        urlGetBooks + "&page=${page ?? 1}&take=10&name=${bookName ?? ""}",
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode != 200) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
