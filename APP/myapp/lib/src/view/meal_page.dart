import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:myapp/src/app_bar.dart';
import 'package:myapp/src/controller/date_controller.dart';
import 'package:myapp/src/model/fonts.dart';
import 'package:myapp/src/model/meal.dart';
import 'package:myapp/src/model/meal_repository.dart';
import 'package:myapp/src/model/menu.dart';
import 'package:myapp/src/model/menu_repository.dart';
import 'meal_list_view.dart';

class MealPage extends StatefulWidget {
  const MealPage({Key? key}) : super(key: key);

  @override
  _MealPage createState() => _MealPage();
}

class _MealPage extends State<MealPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateController>(builder: (controller) {
      return Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            const SizedBox(height: 120),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('오늘의 식단', style: CustomFont().title),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(MdiIcons.plus, size: 32),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          primary: Colors.white,
                          onPrimary: Colors.blue[400],
                          shadowColor: Colors.grey,
                        ))),
              ],
            ),
            MealContainer(
              scrollController: _scrollController,
              dateTime: controller.dateText,
            ),
          ],
        ),
      );
    });
  }
}
// 식단 위젯
class MealContainer extends StatelessWidget {
  MealContainer({
    Key? key, 
    required this.scrollController,
    required this.dateTime,
  }) : super(key: key) {
    menuList = MenuRepository.loadMenusWithDate(dateTime);
    mealList = MealRepository(menuList: menuList).loadMeals();
  }

  final ScrollController scrollController;
  final DateTime dateTime;
  late final List<Menu> menuList;
  late final List<Meal> mealList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: mealList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
              child: MealList(mealData: mealList[index]),
            );
          },
        ),
      ),
    );
  }
}
