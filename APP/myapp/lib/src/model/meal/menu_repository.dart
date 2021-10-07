import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'food.dart';
import 'menu.dart';

class MenuRepository {
  final DateTime dateTime;
  List<Menu>? menuList;

  static final _allMenus = <Menu>[
    Menu(
      dateTime: DateTime.utc(2021, 09, 24),
      meals: <String>['간장계란밥', '어묵콩나물국', '멸치볶음', '감자매운조림'],
      order: 1,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 24),
      meals: <String>['전곡쇠고기영양밥', '돼지고기감자찌개', '황태채무침'],
      order: 2,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 24),
      meals: <String>['닭고기육개장', '생선가스', '야채샐러드'],
      order: 3,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 25),
      meals: <String>['쇠고기감자국', '돼지고기김치볶음', '맛김', '두부조림'],
      order: 1,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 25),
      meals: <String>['쫄면', '콩나물국', '만두튀김', '단무지무침'],
      order: 2,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 25),
      meals: <String>['닭곰탕', '공중떡볶이', '버섯감자채볶음'],
      order: 3,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 10, 05),
      meals: <String>['배추두부국', '소시지김치볶음', '오이무침', '열무김치'],
      order: 1,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 10, 05),
      meals: <String>['열무비빔밥', '순두부국', '오징어튀김', '계란후라이'],
      order: 2,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 10, 05),
      meals: <String>['김치찌개', '야채튀김', '코다리순살콩나물찜'],
      order: 3,
    ),
  ];

  MenuRepository(this.dateTime);

  static Future<Menu> fetchMenu(DateTime dateTime, int order) async {
    String date = dateTime.toString();
    String noTimeDate = date.substring(0, 10);
    final response = await http.get(
        Uri.parse('https://helpmeal.duckdns.org/menus/1/$noTimeDate/2'));
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
      return Menu(dateTime: dateTime, order: order, meals: []);
      //throw Exception('failed!');
    }
  }

  static Future<List<Menu>> getMenus(DateTime dateTime) async {
    Menu breakMenu = await fetchMenu(dateTime, 1);
    Menu lunchMenu = await fetchMenu(dateTime, 2);
    Menu dinnerMenu = await fetchMenu(dateTime, 3);

    return [breakMenu, lunchMenu, dinnerMenu];
  }
}