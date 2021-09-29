import 'package:myapp/src/model/meal.dart';
import 'package:myapp/src/model/menu.dart';

class MealRepository {
  List<Menu>? menuList;

  MealRepository({required this.menuList});

  List<Meal> loadMeals() {
    return <Meal>[
      Meal(
        dateTime: errorCheck(0) ? menuList![0].dateTime : DateTime(1999),
        titleText: '아침',
        meals: errorCheck(0) ? menuList![0].meals : [],
        startColor: 0xFFFA7D82,
        endColor: 0xFFFFB295,
      ),
      Meal(
        dateTime: errorCheck(1) ? menuList![1].dateTime : DateTime(1999),
        titleText: '점심',
        meals: errorCheck(1) ? menuList![1].meals : [],
        startColor: 0xFF738AE6,
        endColor: 0xFF5C5EDD,
      ),
      Meal(
        dateTime: errorCheck(2) ? menuList![2].dateTime : DateTime(1999),
        titleText: '저녁',
        meals: errorCheck(2) ? menuList![2].meals : [],
        startColor: 0xFF6F72CA,
        endColor: 0xFF1E1466,
      ),
    ];
  }

  bool errorCheck(int idx){
    return (menuList != null) && (menuList!.length > idx);
  }
}
