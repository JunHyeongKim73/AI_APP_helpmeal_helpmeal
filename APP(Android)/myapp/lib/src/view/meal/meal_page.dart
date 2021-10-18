import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:myapp/src/app_bar.dart';
import 'package:myapp/src/controller/date_controller.dart';
import 'package:myapp/src/model/fonts.dart';
import 'package:myapp/src/model/meal/meal.dart';
import 'package:myapp/src/model/meal/meal_repository.dart';
import 'package:myapp/src/model/meal/menu.dart';
import 'package:myapp/src/model/meal/menu_repository.dart';
import 'package:myapp/src/model/user/user.dart';
import 'meal_item_view.dart';

class MealPage extends StatefulWidget {
  final User user;
  const MealPage({required this.user, Key? key}) : super(key: key);

  @override
  _MealPage createState() => _MealPage();
}

class _MealPage extends State<MealPage> {
  final _scrollController = ScrollController();
  bool isMealEmpty = true;
  Future<List<Menu>>? futureMenuList;
  bool canGetMenu = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateController>(builder: (controller) {
      if (canGetMenu || controller.dateChanged) {
        futureMenuList = MenuRepository.getMenus(
            controller.dateText, widget.user.groups!.troopId!);
        controller.dateChanged = false;
        canGetMenu = false;
      }
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
                FutureBuilder<List<Menu>>(
                    future: futureMenuList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        isMealEmpty = MenuRepository.checkEmpty(snapshot.data!);

                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: (isMealEmpty && widget.user.isLogined!)
                              ? ElevatedButton(
                                  onPressed: () async {
                                    await Get.toNamed('/mealControl',
                                        arguments: widget.user);
                                    setState(() {
                                      canGetMenu = true;
                                    });
                                  },
                                  child: const Icon(MdiIcons.plus, size: 32),
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    primary: Colors.white,
                                    onPrimary: Colors.blue[400],
                                    shadowColor: Colors.blue[400],
                                  ))
                              : null,
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
            MealContainer(
              scrollController: _scrollController,
              user: widget.user,
              futureMenuList: futureMenuList!,
            ),
          ],
        ),
      );
    });
  }
}

// 식단 위젯
class MealContainer extends StatefulWidget {
  final ScrollController scrollController;
  final Future<List<Menu>> futureMenuList;
  final User user;

  const MealContainer(
      {Key? key,
      required this.scrollController,
      required this.user,
      required this.futureMenuList})
      : super(key: key);

  @override
  State<MealContainer> createState() => _MealContainerState();
}

class _MealContainerState extends State<MealContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Scrollbar(
        controller: widget.scrollController,
        child: FutureBuilder<List<Menu>>(
            future: widget.futureMenuList,
            builder: (context, snapshot) {
              List<Meal> mealList = [];
              if (snapshot.hasData) {
                mealList = MealRepository.loadMeals(snapshot.data!);
              }
              return ListView.builder(
                controller: widget.scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.hasData ? mealList.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 8, right: 8, bottom: 16),
                    child: MealItem(
                        mealData: mealList[index],
                        user: widget.user,
                        index: index),
                  );
                },
              );
            }),
      ),
    );
  }
}
