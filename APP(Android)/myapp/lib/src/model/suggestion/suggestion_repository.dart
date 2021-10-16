import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/src/model/suggestion/suggestion.dart';

class SuggestionRepository {
  static Future<List<Suggestion>> getSuggestion(int troopId) async {
    final response = await http
        .get(Uri.parse('https://helpmeal.duckdns.org/suggestion/$troopId'));

    var suggestionList = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Suggestion Get!');
      List<Suggestion> lists = [];
      for (var suggest in suggestionList) {
        lists.add(Suggestion.fromJson(suggest));
      }

      return lists;
    } else {
      throw Exception('failed');
    }
  }

  static Future<List<Suggestion>> getSuggestionByUser(int userId) async {
    final response = await http.get(
        Uri.parse('https://helpmeal.duckdns.org/suggestion/users/$userId'));

    var suggestionList = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Suggestion Get!');
      List<Suggestion> lists = [];
      for (var suggest in suggestionList) {
        lists.add(Suggestion.fromJsonByUser(
            comment: suggest['comment'], time: suggest['created_at']));
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
