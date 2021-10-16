import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/model/troop/group.dart';
import 'package:myapp/src/model/troop/troop_repository.dart';

class SelectTroopController extends GetxController {
  var troopList = TroopRepository.troopList;

  var pageIndex = 0;

  var isIconSelected = [false, false, false];
  var selectedIconIndex = -1;
  var selectedTroopIndex = -1;
  var selectedDetailTroopIndex = -1;
  var selectedGroupIndex = -1;

  bool isPlusContainerOn = false;
  bool isThirdPageOn = false;

  String milName = '';
  String troopName = '';
  String detailTroopName = '';
  String groupName = '';
  Group? selectedGroup;

  bool isGroupChanged = true;

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

  void changeSelectedIconIndex(int index, String text) {
    if (selectedIconIndex != -1) {
      isIconSelected[selectedIconIndex] = !isIconSelected[selectedIconIndex];
    }
    isIconSelected[index] = !isIconSelected[index];
    selectedIconIndex = index;

    milName = text;

    update();
  }

  void changeSelectedTroopIndex(int index, String text) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
    isPlusContainerOn = true;
    selectedTroopIndex = index;
    troopName = text;
    update();
  }

  void changeButton(int index, String text) {
    if (pageIndex == 1) {
      if (isPlusContainerOn) {
        selectedDetailTroopIndex = index;
        detailTroopName = text;
      } else {
        selectedTroopIndex = index;
        troopName = text;
      }
      isThirdPageOn = true;
    } else {
      selectedGroupIndex =
          selectedGroupIndex == index ? -1 : selectedGroupIndex = index;
      groupName = text;
    }
    update();
  }

  void setGroup(Group group) {
    selectedGroup = group;
    update();
  }

  List<String> getParams() {
    List<String> _lists = [milName, troopName];
    if (detailTroopName != '') {
      _lists.add(detailTroopName);
    }

    return _lists;
  }

  void updateGroupChanged() {
    isGroupChanged = !isGroupChanged;
    update();
  }
}
