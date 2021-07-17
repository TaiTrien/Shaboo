import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shaboo/constants/api_constants.dart';

import 'package:shaboo/data/models/post/post.dart';
import 'package:shaboo/data/models/response/response.dart';

import 'package:shaboo/utils/store.dart';

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
    var requestedPost = PostModel.convertPostToMap(post: post);

    try {
      var response = await http.post(
        Uri.parse(urlUploadPost),
        headers: await getHeader(),
        body: jsonEncode(requestedPost),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> updatePost({PostModel selectedPost}) async {
    var reqBook = {
      "title": selectedPost.title,
      "description": selectedPost.description,
      "status": selectedPost.status,
      "location": selectedPost.location,
      "images": selectedPost.images.map((image) => image.imageID).toList(),
    };

    try {
      var response = await http.put(
        Uri.parse(urlPosts + '/${selectedPost.id}'),
        headers: await getHeader(),
        body: jsonEncode(reqBook),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
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

  static Future<dynamic> getPosts(EOrder eOrder, int page, int take, int bookId, bool owned) async {
    try {
      var response = await http.get(
        Uri.parse(
            '$urlPosts?order=${order[eOrder.index]}&page=${page ?? 1}&take=$take&status=OPENED&bookId=${bookId ?? ''}&owned=${owned ?? 'false'}'),
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
        Uri.parse('$urlPosts/$id'),
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
