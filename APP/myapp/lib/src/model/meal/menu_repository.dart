import 'dart:convert';

import 'package:http/http.dart' as http;
import 'food.dart';
import 'menu.dart';

class MenuRepository {
  static int num = 1;

  static Future<Menu> fetchMenu(DateTime dateTime, Category category) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);
    final response = await http.get(Uri.parse(
        'https://helpmeal.duckdns.org/menus/1/$noTimeDate/${category.index + 1}'));
    if (response.statusCode == 200) {
      print('GET SUCCESS');
      var lists = jsonDecode(response.body);
      List<Food> foodList = [];
      for (var element in lists) {
        foodList.add(Food.fromJson(element));
      }
      return Menu(dateTime: dateTime, category: category, foodList: foodList);
    } else if (response.statusCode == 400) {
      num = 0;
      return Menu(dateTime: dateTime, category: category, foodList: []);
    } else {
      throw Exception('failed!');
    }
  }

  static Future<List<Menu>> getMenus(DateTime dateTime) async {
    Menu breakMenu = await fetchMenu(dateTime, Category.breakfast);
    Menu lunchMenu = await fetchMenu(dateTime, Category.lunch);
    Menu dinnerMenu = await fetchMenu(dateTime, Category.dinner);

    return [breakMenu, lunchMenu, dinnerMenu];
  }

  static Future<MenuForPost> createMenu(DateTime dateTime, int order, List<Map> foods) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);

    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/menus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "troopId": 1,
        "numberOfDay": order,
        "day": noTimeDate,
        "menus": foods,
      }),
    );
    if (response.statusCode == 200) {
      print('POST SUCCESS');
      print(jsonDecode(response.body));
      return MenuForPost.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed');
    }
  }

  static Future<void> postMenu(DateTime dateTime, List<List<Map>> foodList) async {
    MenuForPost menu1 = await createMenu(dateTime, 1, foodList[0]);
    MenuForPost menu2 = await createMenu(dateTime, 2, foodList[1]);
    MenuForPost menu3 = await createMenu(dateTime, 3, foodList[2]);
  }
}

class MenuForPost{
  int troopId;
  int numberOfDay;
  String day;
  var menus;

  MenuForPost({required this.troopId, required this.numberOfDay, required this.day, required this.menus});

  factory MenuForPost.fromJson(Map<String, dynamic> json) {
    return MenuForPost(
      troopId: json['troopId'],
      numberOfDay: json['numberOfDay'],
      day: json['day'],
      menus: json['menus'],
    );
  }
}
