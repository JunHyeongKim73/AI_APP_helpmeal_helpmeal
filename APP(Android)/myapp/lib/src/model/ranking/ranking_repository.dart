//import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ranking.dart';

class RankingRepository {
  static Future<List<Ranking>> getBestMenu(String unit) async {
    String duration;
    switch (unit) {
      case '일간':
        duration = 'day'; 
        break;
      case '주간':
        duration = 'week';
        break;
      default:
        duration = 'month';
        break;
    }
    final response = await http.get(
      Uri.parse('https://helpmeal.duckdns.org/menus/best/?duration=$duration'),
    );
    var rankingList = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Ranking> lists = [];
      for (var ranking in rankingList) {
        lists.add(Ranking.fromJson(ranking));
      }
      return lists;
    } else {
      throw Exception('failed');
    }
  }
}
