import 'dart:convert';
import 'package:http/http.dart' as http;

import 'review.dart';
import 'star.dart';

class ReviewRepository {
  static Future<List<Review>> getMyReview(int userId) async {
    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/reviews/myReview'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'userId': userId}),
    );

    var reviewList = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('Review Get!');
      List<Review> lists = [];
      for (var review in reviewList) {
        lists.add(Review.fromJsonByUser(review));
      }

      return lists;
    } else {
      throw Exception('failed');
    }
  }

  static Future<List<Review>> getFoodReview(
      DateTime dateTime, int troopId, int index) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);
    final response = await http.get(
      Uri.parse(
          'https://helpmeal.duckdns.org/reviews/$troopId/$noTimeDate/$index'),
    );

    var reviewList = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Review Get!');
      List<Review> lists = [];
      for (var review in reviewList) {
        lists.add(Review.fromJsonByUser(review));
      }

      return lists;
    } else {
      throw Exception('failed');
    }
  }

  static Future<String> postReview(DateTime dateTime, int troopId, int index,
      int userId, String comment) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);

    final response = await http.post(
      Uri.parse(
          'https://helpmeal.duckdns.org/reviews/$troopId/$noTimeDate/$index'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'userId': userId, 'comment': comment}),
    );

    if (response.statusCode == 201) {
      print('success Post');
      return '저장되었습니다';
    } else if (response.statusCode == 401) {
      print('Already Inserted!');
      return '이미 리뷰를 작성하였습니다!';
    } else {
      throw Exception('failed');
    }
  }

  static Future<void> postStar(
      DateTime dateTime, int troopId, int index, List<Star> starList) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);

    List<Map<String, dynamic>> mapList = [];
    for (var star in starList) {
      mapList.add(star.mapData!);
    }

    final response = await http.post(
      Uri.parse(
          'https://helpmeal.duckdns.org/stars/$troopId/$noTimeDate/$index'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(mapList),
    );

    if (response.statusCode == 201) {
      print('success Post');
    } else {
      throw Exception('failed');
    }
  }
}
