import 'dart:convert';

import 'package:http/http.dart' as http;
import 'food.dart';
import 'menu.dart';

class MenuRepository {
  static Future<Menu> fetchMenu(
      DateTime dateTime, Category category, int troopId) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);
    final response = await http.get(Uri.parse(
        'https://helpmeal.duckdns.org/menus/$troopId/$noTimeDate/${category.index + 1}'));
    if (response.statusCode == 200) {
      print('Get Menu!');
      var lists = jsonDecode(response.body);
      List<Food> foodList = [];
      for (var element in lists) {
        foodList.add(Food.fromJson(element));
      }
      return Menu(dateTime: dateTime, category: category, foodList: foodList);
    } else if (response.statusCode == 400) {
      return Menu(dateTime: dateTime, category: category, foodList: []);
    } else {
      throw Exception('failed!');
    }
  }

  static Future<List<Menu>> getMenus(DateTime dateTime, int troopId) async {
    Menu breakMenu = await fetchMenu(dateTime, Category.breakfast, troopId);
    Menu lunchMenu = await fetchMenu(dateTime, Category.lunch, troopId);
    Menu dinnerMenu = await fetchMenu(dateTime, Category.dinner, troopId);

    return [breakMenu, lunchMenu, dinnerMenu];
  }

  static bool checkEmpty(List<Menu> menus) {
    bool isEmpty = true;
    for (var menu in menus) {
      if (menu.foodList.isNotEmpty) {
        isEmpty = false;
      }
    }
    return isEmpty;
  }

  static Future<void> createMenu(
      DateTime dateTime, int order, List<Map> foods, int troopId) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);

    final response = await http.put(
      Uri.parse('https://helpmeal.duckdns.org/menus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "troopId": troopId,
        "numberOfDay": order,
        "day": noTimeDate,
        "menus": foods,
      }),
    );
    if (response.statusCode == 200) {
      print('Post Menu!');
    } else {
      throw Exception('failed');
    }
  }

  static Future<void> updateMenu(
      DateTime dateTime, int order, List<Map> foods, int troopId) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);

    final response = await http.put(
      Uri.parse('https://helpmeal.duckdns.org/menus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "troopId": troopId,
        "numberOfDay": order,
        "day": noTimeDate,
        "menus": foods,
      }),
    );
    if (response.statusCode == 200) {
      print('Put Menu!');
    } else {
      throw Exception('failed');
    }
  }

  static Future<void> postMenu(DateTime dateTime, List<List<Map>> foodList,
      List<bool> flags, int troopId) async {
    for (int i = 0; i < 3; i++) {
      if(flags[i]){
        await createMenu(dateTime, i+1, foodList[i], troopId);
      }
      else{
        await updateMenu(dateTime, i+1, foodList[i], troopId);
      }
    }
  }
}
