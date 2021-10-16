import 'food.dart';

class Meal {
  final DateTime dateTime;
  final String titleText;
  final int startColor;
  final int endColor;
  final List<Food> foodList;

  Meal({
    required this.dateTime,
    required this.titleText,
    required this.startColor,
    required this.endColor,
    required this.foodList,
  });
}