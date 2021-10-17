import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:myapp/src/model/analysis/analysis_review.dart';

import 'analysis_menu.dart';

class AnalysisRepository {
  static Future<List<MenuAnalysis>> getMenuAnalysis(String flag) async {
    final response = await http.get(Uri.parse(
        'https://helpmeal.duckdns.org/menus/$flag?duration=week'));

    var menuAnalysisList = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      print('Menu Analysis Get!');
      List<MenuAnalysis> lists = [];
      for (var menuAnalysis in menuAnalysisList) {
        lists.add(MenuAnalysis.fromJson(menuAnalysis));
      }
      return lists;
    } else {
      throw Exception('failed');
    }
  }

  static Future<List<ReviewAnalysis>> getReviewAnalysis(String flag) async {
    final response = await http.get(Uri.parse(
        'https://helpmeal.duckdns.org/reviews/analytics/wordCount/$flag'));

    var reviewAnalysisList = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Review Analysis Get!');
      List<ReviewAnalysis> lists = [];
      for (var reviewAnalysis in reviewAnalysisList) {
        lists.add(ReviewAnalysis.fromJson(reviewAnalysis));
      }

      return lists;
    } else {
      throw Exception('failed');
    }
  }
}
