import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:myapp/src/app_bar.dart';
import 'package:myapp/src/controller/date_controller.dart';
import 'package:myapp/src/model/fonts.dart';
import 'package:myapp/src/model/meal/food.dart';
import 'package:myapp/src/model/meal/meal.dart';
import 'package:myapp/src/model/meal/meal_repository.dart';
import 'package:myapp/src/model/meal/menu.dart';
import 'package:myapp/src/model/meal/menu_repository.dart';
import 'package:myapp/src/model/user.dart';
import 'meal_item_view.dart';

class MealPage extends StatefulWidget {
  User user;
  MealPage({required this.user, Key? key}) : super(key: key);

  @override
  _MealPage createState() => _MealPage();
}

class _MealPage extends State<MealPage> {
  final _scrollController = ScrollController();
  late Future<Menu> futureFood;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateController>(builder: (controller) {
      // widget.user -> 유저의 알러지 확인!
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
              user: widget.user,
            ),
          ],
        ),
      );
    });
  }
}

// 식단 위젯
class MealContainer extends StatelessWidget {
  final ScrollController scrollController;
  final DateTime dateTime;
  User user;
  late final Future<List<Meal>> futureMealList;

  MealContainer({
    Key? key,
    required this.scrollController,
    required this.dateTime,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    futureMealList = MealRepository(dateTime: dateTime).loadMeals();
    return SizedBox(
      height: 280,
      child: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: FutureBuilder<List<Meal>>(
          future: futureMealList,
          builder: (context, snapshot) {
            return ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
                  child: MealItem(mealData: snapshot.data![index], user: user),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
