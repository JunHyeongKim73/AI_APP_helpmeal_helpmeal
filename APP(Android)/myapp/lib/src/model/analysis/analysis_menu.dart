class MenuAnalysis {
  final String name;
  final double averageStar;
  final int rateNumber;

  MenuAnalysis({
    required this.name,
    required this.averageStar,
    required this.rateNumber,
  });

  factory MenuAnalysis.fromJson(Map<String, dynamic> json) {
    return MenuAnalysis(
      name: json['name'],
      averageStar: json['average_star'],
      rateNumber: json['rate_number'],
    );
  }
}