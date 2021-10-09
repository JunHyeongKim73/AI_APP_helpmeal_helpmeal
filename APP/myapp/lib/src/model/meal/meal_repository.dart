import 'package:myapp/src/model/meal/menu_repository.dart';

import 'meal.dart';
import 'menu.dart';

class MealRepository {
  final DateTime dateTime;

  MealRepository({required this.dateTime});

  Future<List<Menu>> getMenu() async {
    List<Menu> menus = await MenuRepository.getMenus(dateTime);
    return menus;
  }

  Future<List<Meal>> loadMeals() async {
    List<Menu> menuList = await getMenu();
    
    return <Meal>[
      Meal(
        dateTime: menuList[0].dateTime,
        titleText: '아침',
        foodList: menuList[0].foodList,
        startColor: 0xFFFA7D82,
        endColor: 0xFFFFB295,
      ),
      Meal(
        dateTime: menuList[1].dateTime,
        titleText: '점심',
        foodList: menuList[1].foodList,
        startColor: 0xFF738AE6,
        endColor: 0xFF5C5EDD,
      ),
      Meal(
        dateTime: menuList[2].dateTime,
        titleText: '저녁',
        foodList: menuList[2].foodList,
        startColor: 0xFF6F72CA,
        endColor: 0xFF1E1466,
      ),
    ];
  }
}
