import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/model/troop_repository.dart';

class SelectTroopController extends GetxController {
  var troopList = TroopRepository.troopList;

  var pageIndex = 0;

  var selectedIconIndex = -1;
  var isIconSelected = [false, false, false];

  bool isPlusContainerOn = false;
  var selectedTroopIndex = -1;

  var selectedDetailTroopIndex = -1;
  var selectedGroupIndex = -1;
  bool isThirdPageOn = false;
  String groupName = '';

  final PageController pageController = PageController(initialPage: 0);

  void nextPage() {
    if (pageIndex == 0 && selectedIconIndex == -1) return;
    if (pageIndex == 1 && !isThirdPageOn) return;
    if (pageIndex == 1 && !isPlusContainerOn) {
      pageController.jumpToPage(3);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    }
    pageIndex++;
    update();
  }

  void previousPage() {
    if (pageIndex == 2) {
      isThirdPageOn = false;
      if (isPlusContainerOn) {
        selectedDetailTroopIndex = -1;
      } else {
        selectedTroopIndex = -1;
        selectedDetailTroopIndex = -1;
        pageController.jumpToPage(1);
        pageIndex--;
        update();
        return;
      }
    }
    pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
    if (pageIndex == 1) {
      if (isPlusContainerOn) {
        selectedTroopIndex = -1;
        isPlusContainerOn = false;
        update();
        return;
      } else {
        selectedIconIndex = -1;
      }
    }

    pageIndex--;
    update();
  }

  void changeSelectedIconIndex(int index) {
    if (selectedIconIndex != -1) {
      isIconSelected[selectedIconIndex] = !isIconSelected[selectedIconIndex];
    }
    isIconSelected[index] = !isIconSelected[index];
    selectedIconIndex = index;
    update();
  }

  void changeSelectedTroopIndex(int index) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
    isPlusContainerOn = true;
    selectedTroopIndex = index;
    update();
  }

  void changeButton(int index) {
    if (pageIndex == 1) {
      if (isPlusContainerOn) {
        selectedDetailTroopIndex = index;
      } else {
        selectedTroopIndex = index;
      }
      isThirdPageOn = true;
    } else {
      selectedGroupIndex =
          selectedGroupIndex == index ? -1 : selectedGroupIndex = index;
    }
    update();
  }

  void addGroup(String name) {
    if (selectedDetailTroopIndex == -1) {
      var tempList =
          troopList[selectedIconIndex].troops![selectedTroopIndex].groups;
      tempList!.removeLast();
      tempList.add(name);
      tempList.add('+');
    } else {
      var tempList = troopList[selectedIconIndex]
          .troops![selectedTroopIndex]
          .troops![selectedDetailTroopIndex]
          .groups;
      tempList!.removeLast();
      tempList.add(name);
      tempList.add('+');
    }
    update();
  }
}
