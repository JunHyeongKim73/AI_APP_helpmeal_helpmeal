import 'package:http/http.dart' as http;

enum Category { breakfast, lunch, dinner }

class Menu {
  final DateTime dateTime;
  final List<String?> meals;
  final int order;

  Menu({required this.dateTime, required this.meals, required this.order});
  
}
