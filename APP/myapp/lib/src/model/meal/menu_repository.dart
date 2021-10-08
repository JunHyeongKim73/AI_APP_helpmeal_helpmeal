import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'food.dart';
import 'menu.dart';

class MenuRepository {

  static Future<Menu> fetchMenu(DateTime dateTime, int order) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);
    final response = await http
        .get(Uri.parse('https://helpmeal.duckdns.org/menus/1/$noTimeDate/$order'));
    if (response.statusCode == 200) {
      List lists = jsonDecode(response.body);
      List<String?> meals = [];
      for (var element in lists) {
        Food food = Food.fromJson(element);
        meals.add(food.name);
      }
      return Menu(dateTime: dateTime, order: order, meals: meals);
    } else if (response.statusCode == 400) {
      return Menu(dateTime: dateTime, order: order, meals: []);
    } else {
      throw Exception('failed!');
    }
  }

  static Future<List<Menu>> getMenus(DateTime dateTime) async {
    Menu breakMenu = await fetchMenu(dateTime, 1);
    Menu lunchMenu = await fetchMenu(dateTime, 2);
    Menu dinnerMenu = await fetchMenu(dateTime, 3);

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
