import 'dart:convert';

import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/utils/store.dart';
import 'package:http/http.dart' as http;

class ReviewApi {
  static String urlGeneralReview = '$kPrefixUrl/reviews';

  static getHeader() async => {
        "Authorization": "Bearer ${await Store.getToken()}",
        "Content-Type": "application/json",
      };

  static Future<dynamic> postReview({ReviewModel review}) async {
    try {
      var response = await http.post(
        Uri.parse(urlGeneralReview),
        headers: await getHeader(),
        body: jsonEncode(review),
      );

      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> editReview({ReviewModel review}) async {
    try {
      var response = await http.put(
        Uri.parse(urlGeneralReview + "/${review.id}"),
        headers: await getHeader(),
        body: jsonEncode(review),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> deleteReview({int reviewId}) async {
    try {
      var response = await http.delete(
        Uri.parse(urlGeneralReview + "/$reviewId"),
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getReviews({EOrder eOrder, int page, String bookId}) async {
    try {
      var response = await http.get(
        Uri.parse(urlGeneralReview + "?${order[eOrder.index] ?? order[0]}&page=${page ?? 1}&take=10&bookId=$bookId"),
        headers: await getHeader(),
      );
      if (!successCodes.contains(response.statusCode)) return null;
      print(json.decode(response.body));
      //return Response.map(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
