import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/tutorial/youtube/src/pages/home.dart';
import 'controller/app_controller.dart';
import 'pages/library.dart';
import 'pages/search.dart';
import 'pages/subscribe.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final index = controller.currentIndex.value;
        switch(RouteName.values[index]){
          case RouteName.Home:
            return Home();
            break;
          case RouteName.Search:
            return Search();
            break;
          case RouteName.Add:
            break;
          case RouteName.Subs:
            return Subscribe();
            break;
          case RouteName.Library:
            return Library();
            break;
        }
        return Container();
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          onTap: controller.ChangePageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.grey,
                  size: 22,
                ),
                activeIcon: Icon(Icons.home, color: Colors.grey, size: 22),
                label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_off,
                  color: Colors.grey,
                  size: 22,
                ),
                activeIcon: Icon(Icons.search, color: Colors.grey, size: 22),
                label: 'search'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Colors.grey,
                  size: 35,
                ),
                activeIcon: Icon(Icons.add_box, color: Colors.grey, size: 35),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.unsubscribe_outlined,
                  color: Colors.grey,
                  size: 22,
                ),
                activeIcon:
                    Icon(Icons.unsubscribe, color: Colors.grey, size: 22),
                label: 'subscribe'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.restore_outlined,
                  color: Colors.grey,
                  size: 22,
                ),
                activeIcon:
                    Icon(Icons.restore_rounded, color: Colors.grey, size: 22),
                label: 'store'),
          ],
        ),
      ),
    );
  }
}
