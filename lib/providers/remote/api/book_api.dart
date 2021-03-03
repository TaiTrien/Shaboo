import 'dart:convert';

import 'package:shaboo/models/response/response.dart';
import 'package:shaboo/constants/api_constants.dart';
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

  static Future<dynamic> getBooks({EOrder eOrder, int page, String bookName, EOrder orderBy}) async {
    try {
      var _query;
      if (orderBy != null) {
        _query =
            "?order=${order[eOrder.index] ?? order[0]}&page=${page ?? 1}&take=10&orderBy=${order[orderBy.index]}&name=${bookName ?? ""}";
      } else {
        _query = "?order=${order[eOrder.index] ?? order[0]}&page=${page ?? 1}&take=10&name=${bookName ?? ""}";
      }

      var response = await http.get(
        urlGetBooks + _query,
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
