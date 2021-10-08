import 'package:http/http.dart' as http;

enum Category { breakfast, lunch, dinner }

class Menu {
  final DateTime dateTime;
  final List<String> meals;
  final Category category;

  Menu({required this.dateTime, required this.meals, required this.category});
}
