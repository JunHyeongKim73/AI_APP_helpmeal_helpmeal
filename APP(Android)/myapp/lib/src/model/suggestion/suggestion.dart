import 'package:intl/intl.dart';

class Suggestion {
  int? troopId;
  String? comment;
  String? time;
  String? createdTime;
  String? name;

  Suggestion({this.troopId, this.comment, this.time, this.name}) {
    DateTime dateTime = DateTime.parse(time!);
    createdTime = DateFormat.yMMMd('ko').format(dateTime);
  }

  Suggestion.fromJsonByUser({this.comment, this.time}) {
    DateTime dateTime = DateTime.parse(time!);
    createdTime = DateFormat.yMMMd('ko').format(dateTime);
  }

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      troopId: json['troop_id'],
      comment: json['comment'],
      time: json['created_at'],
      name: json['name'],
    );
  }
}
