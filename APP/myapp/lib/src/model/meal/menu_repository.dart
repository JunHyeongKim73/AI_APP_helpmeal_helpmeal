import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'food.dart';
import 'menu.dart';

class MenuRepository {

  static Future<Menu> fetchMenu(DateTime dateTime, Category category) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);
    final response = await http
        .get(Uri.parse('https://helpmeal.duckdns.org/menus/1/$noTimeDate/${category.index+1}'));
    if (response.statusCode == 200) {
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

  static Future<List<Menu>> getMenus(DateTime dateTime) async {
    Menu breakMenu = await fetchMenu(dateTime, Category.breakfast);
    Menu lunchMenu = await fetchMenu(dateTime, Category.lunch);
    Menu dinnerMenu = await fetchMenu(dateTime, Category.dinner);

    return [breakMenu, lunchMenu, dinnerMenu];
  }

  static void createMenu(DateTime dateTime, int order, List<Map> foods) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);
    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/menus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'troopID' : 1,
        'numberOfDay' : 3,
        'day' : '2021-10-08',
        'menus' : foods,
      }),
    );

    print(response);
    print('status : ${response.statusCode}');
  }

  static void postMenu(DateTime dateTime, List<List<Map>> foodList){
    createMenu(dateTime, 1, foodList[0]);
  }
}
