import 'meal.dart';
import 'menu.dart';

class MealRepository {
  static List<Meal> loadMeals(List<Menu> menuList) {
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
