import 'package:myapp/src/model/meal/food.dart';

enum Category { breakfast, lunch, dinner }

class Menu {
  final DateTime dateTime;
  final List<Food> foodList;
  final Category category;

  Menu({required this.dateTime, required this.foodList, required this.category});
  
  List<String?> get foodNames{
    List<String?> lists = [];
    for(var food in foodList){
      lists.add(food.name);
    }
    return lists;
  }
}
