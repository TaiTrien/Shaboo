import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/model/response.dart';

import 'package:shaboo/utils/store.dart';
import './constants.dart';

class PostApi {
  // static String prefixUrl = 'http://10.0.128.70:3001';
  static String urlUploadPost = '$kPrefixUrl/posts';
  static String urlPosts = '$kPrefixUrl/posts';
  static String urlUploadPhoto = '$kPrefixUrl/images';
  static String urlGetBooks = '$kPrefixUrl/books?order=ASC';
  static getHeader() async => {
        "Authorization": "Bearer ${await Store.getToken()}",
        "Content-Type": "application/json",
      };

  static Future<dynamic> uploadPost({PostModel post}) async {
    var token = await Store.getToken();
    var requestedPost = PostModel.converPostToMap(post: post);

    try {
      var response = await http.post(
        urlUploadPost,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestedPost),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

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

      if (!successCodes.contains(response.statusCode)) return null;
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
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getPosts(EOrder eOrder, int page, int take) async {
    try {
      var response = await http.get(
        '$urlPosts?order=${order[eOrder.index]}&page=$page&take=$take&status=OPENED',
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getPostById(int id) async {
    try {
      var response = await http.get(
        '$urlPosts/$id',
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
