import 'package:intl/intl.dart';

class Notice {
  String? title;
  String? content;
  String? time;
  String? createdTime;

  Notice({this.title, this.content, this.time}) {
    DateTime dateTime = DateTime.parse(time!);
    createdTime = DateFormat.yMMMd('ko').add_jm().format(dateTime);
  }

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      title: json['title'],
      content: json['content'],
      time: json['created_at'],
    );
  }
}
