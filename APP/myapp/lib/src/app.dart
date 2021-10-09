import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/src/model/user/user.dart';

import 'controller/navigate_page_controller.dart';
import 'view/meal/meal_page.dart';
import 'view/my_page.dart';
import 'view/ranking_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.arguments;
    User user;
    if (signUpController == null) {
      user = User(
        email: 'rla5764',
        name: '김준형',
        milName: 'airforce',
        troopName: '공군 작전사령부 직할부대',
        groupName: '오산기지',
        allergyList: ['고기'],
        isAdmin: true,
      );
    } else {
      user = User(
        email: signUpController.email,
        password: signUpController.password,
        name: signUpController.name,
        milNum: signUpController.milNum,
        milName: signUpController.milName,
        troopName: signUpController.milNum,
        groupName: signUpController.groupName,
        allergyList: signUpController.allergy,
        isAdmin: signUpController.isAdmin,
      );
    }
    return GetBuilder<NavigatePageController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                MealPage(user: user),
                RankingPage(),
                MyPage(user: user),
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
                ]),
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
