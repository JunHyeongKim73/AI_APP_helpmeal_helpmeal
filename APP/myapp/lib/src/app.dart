import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'controller/navigate_page_controller.dart';
import 'view/meal_page.dart';
import 'view/my_page.dart';
import 'view/ranking_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigatePageController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: const [
                MealPage(),
                RankingPage(),
                MyPage(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0,
                  blurRadius: 10,
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                //elevation: 0,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      MdiIcons.viewDashboard,
                      size: 24,
                    ),
                    label: '식단표',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      MdiIcons.crown,
                      size: 24,
                    ),
                    label: '랭킹',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      MdiIcons.account,
                      size: 24,
                    ),
                    label: 'My',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
