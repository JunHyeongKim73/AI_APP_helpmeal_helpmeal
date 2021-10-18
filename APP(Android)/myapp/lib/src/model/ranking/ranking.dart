import 'dart:convert';

List<Ranking> rankingFromJson(String str) => List<Ranking>.from(json.decode(str).map((x) => Ranking.fromJson(x)));

String rankingToJson(List<Ranking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ranking {
    String? name;
    double? averageStar;
    int? rateNumber;
    DateTime? day;
    int? troopId;

    Ranking({
        this.name,
        this.averageStar,
        this.rateNumber,
        this.day,
        this.troopId,
    });

    factory Ranking.fromJson(Map<String, dynamic> json) => Ranking(
        name: json["name"],
        averageStar: json["average_star"].toDouble(),
        rateNumber: json["rate_number"],
        day: DateTime.parse(json["day"]),
        troopId: json["troop_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "average_star": averageStar,
        "rate_number": rateNumber,
        "day": day!.toIso8601String(),
        "troop_id": troopId,
    };
}