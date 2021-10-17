import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/src/model/notice/notice.dart';

class NoticeRepository {
  static Future<List<Notice>> getNotice(int troopId) async {
    final response = await http
        .get(Uri.parse('https://helpmeal.duckdns.org/notice/$troopId'));

    var noticeList = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Notice Get!');
      List<Notice> lists = [];
      for (var notice in noticeList) {
        lists.add(Notice.fromJson(notice));
      }

      return lists;
    } else {
      throw Exception('failed');
    }
  }

  static Future<void> postnotice(int troopId, String title, String content) async {
    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/notice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'troopId': troopId, 'title': title, 'content': content}),
    );

    if (response.statusCode == 200) {
      print('Notice Post!');
    } else {
      throw Exception('failed');
    }
  }
}
