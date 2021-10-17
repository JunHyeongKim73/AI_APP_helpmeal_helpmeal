//import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ranking.dart';
class RankingRepository {
    static Future<List<Ranking>> getBestMenu(void) async {
        final response = await http.get(
            Uri.parse('https://helpmeal.duckdns.org/menus/best/?duration=week');
        var rankingList = jsonDecode(response.body);
        if(response.statusCode == 200)
            {
                print('Review Get!');
                List<Ranking> lists = [];
                for(var ranking in rankingList) {
                    lists.add(Ranking.fromJson(ranking));
                }
                return lists;
            }
        );
        else {
            throw Exception('failed');
        }
    }
}