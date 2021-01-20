import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/model/response.dart';

import 'package:shaboo/utils/store.dart';
import './constants.dart';

class PostApi {
  static String urlUploadPost = '$kPrefixUrl/posts';
  static String urlPosts = '$kPrefixUrl/posts';
  static String urlUploadPhoto = '$kPrefixUrl/images';
  static String urlGetBooks = '$kPrefixUrl/books?order=ASC';
  static getHeader() async => {
        "Authorization": "Bearer ${await Store.getToken()}",
        "Content-Type": "application/json",
      };

  static Future<dynamic> uploadPost({PostModel post}) async {
    var requestedPost = PostModel.converPostToMap(post: post);

    try {
      var response = await http.post(
        urlUploadPost,
        headers: await getHeader(),
        body: jsonEncode(requestedPost),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> uploadPhoto({List<File> photos}) async {
    var request = http.MultipartRequest('POST', Uri.parse(urlUploadPhoto));

    Map<String, String> headers = await getHeader();
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

  static Future<dynamic> getPosts(EOrder eOrder, int page, int take, int bookId) async {
    try {
      var response = await http.get(
        '$urlPosts?order=${order[eOrder.index]}&page=${page ?? 1}&take=$take&status=OPENED&bookId=${bookId ?? ''}',
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
