class Meal {
  final DateTime dateTime;
  final String titleText;
  final int startColor;
  final int endColor;
  final List<String?> meals;

  Meal({
    required this.dateTime,
    required this.titleText,
    required this.startColor,
    required this.endColor,
    required this.meals,
  });
}