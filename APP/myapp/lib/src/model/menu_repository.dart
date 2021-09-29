import 'package:intl/intl.dart';

import 'menu.dart';

class MenuRepository {
  static final _allMenus = <Menu>[
    Menu(
      dateTime: DateTime.utc(2021, 09, 24),
      meals: <String>['간장계란밥', '어묵콩나물국', '멸치볶음', '감자매운조림'],
      category: Category.breakfast,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 24),
      meals: <String>['전곡쇠고기영양밥', '돼지고기감자찌개', '황태채무침'],
      category: Category.lunch,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 24),
      meals: <String>['닭고기육개장', '생선가스', '야채샐러드'],
      category: Category.dinner,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 25),
      meals: <String>['쇠고기감자국', '돼지고기김치볶음', '맛김', '두부조림'],
      category: Category.breakfast,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 25),
      meals: <String>['쫄면', '콩나물국', '만두튀김', '단무지무침'],
      category: Category.lunch,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 25),
      meals: <String>['닭곰탕', '공중떡볶이', '버섯감자채볶음'],
      category: Category.dinner,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 26),
      meals: <String>['배추두부국', '소시지김치볶음', '오이무침', '열무김치'],
      category: Category.breakfast,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 26),
      meals: <String>['열무비빔밥', '순두부국', '오징어튀김', '계란후라이'],
      category: Category.lunch,
    ),
    Menu(
      dateTime: DateTime.utc(2021, 09, 26),
      meals: <String>['김치찌개', '야채튀김', '코다리순살콩나물찜'],
      category: Category.dinner,
    ),
  ];

  static List<Menu> loadMenusWithDate(DateTime date) {
    List<Menu> list = _allMenus.where((element) => dateForm(element.dateTime) == dateForm(date)).toList();
    
    List<Menu> sortedList = [];
    for(var category in Category.values) {
      for(var element in list) {
        if(category == element.category){
          sortedList.add(element);
        }
      }
    }
    return sortedList;
  }
}

dateForm(DateTime date){
  return DateFormat('yyyy-MM-dd').format(date);
}

