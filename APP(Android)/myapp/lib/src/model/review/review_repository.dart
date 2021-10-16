import 'dart:convert';
import 'package:http/http.dart' as http;

import 'review.dart';

class ReviewRepository {
  static Future<List<Review>> getMyReview(int userId) async {
    print(userId);
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

  static Future<List<Review>> getFoodReview(int userId) async {
    print(userId);
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

  static Future<void> postSuggestion(int userId, String comment) async {
    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/suggestion'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'userId': userId, 'comment': comment}),
    );


    if (response.statusCode == 200) {
      print('success Post');
    } else {
      throw Exception('failed');
    }
  }
}
