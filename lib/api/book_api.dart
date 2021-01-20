import 'dart:convert';

import 'package:shaboo/api/constants.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/model/response.dart';
import 'package:shaboo/utils/store.dart';
import 'package:http/http.dart' as http;

class BookApi {
  static String urlGetBooks = '$kPrefixUrl/books';
  static String urlGetRecommendBooks = '$kPrefixUrl/books/recommend';
  static String urlGetCategories = '$kPrefixUrl/books/categories';

  static getHeader() async => {
        "Authorization": "Bearer ${await Store.getToken()}",
        "Content-Type": "application/json",
      };

  static Future<dynamic> getBooks({EOrder eOrder, int page, String bookName}) async {
    try {
      var response = await http.get(
        urlGetBooks + "?order=${order[eOrder.index] ?? order[0]}&page=${page ?? 1}&take=10&name=${bookName ?? ""}",
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getRecommendBooks({EOrder eOrder, int page}) async {
    try {
      var response = await http.get(
        urlGetRecommendBooks + "?order=${order[0]}&page=${page ?? 1}&take=10",
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getCategories({EOrder eOrder, int page, String categoryName}) async {
    try {
      var response = await http.get(
        urlGetCategories +
            "?order=${order[eOrder.index] ?? order[0]}&page=${page ?? 1}&take=10&name=${categoryName ?? ""}",
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
