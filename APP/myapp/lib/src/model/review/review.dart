import 'package:intl/intl.dart';

class Review {
  String? name;
  String? comment;
  String? time;
  String? createdTime;

  Review({
    this.name,
    this.comment,
    this.time,
  }) {
    DateTime dateTime = DateTime.parse(time!);
    createdTime = DateFormat.yMMMd('ko').add_jm().format(dateTime);
  }

  factory Review.fromJsonByUser(Map<String, dynamic> json) {
    return Review(
        name: json['name'], comment: json['comment'], time: json['created_at']);
  }
}
