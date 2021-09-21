import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/tutorial/youtube/src/components/bottom_sheet.dart';

enum RouteName { Home, Search, Add, Subs, Library }

class AppController extends GetxService {
  static AppController get to => Get.find();
  RxInt currentIndex = 0.obs;

  void ChangePageIndex(int index) {
    if(RouteName.values[index] == RouteName.Add){
      _showBottomSheet();
    }
    else{
      currentIndex(index);
    }
  }

  void _showBottomSheet() {
    Get.bottomSheet(BottomSheets());
  }
}
