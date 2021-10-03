import 'package:get/instance_manager.dart';
import 'package:myapp/src/controller/date_controller.dart';
import 'package:myapp/src/controller/navigate_page_controller.dart';
import 'package:myapp/src/controller/select_troop_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigatePageController>(() => NavigatePageController());
    Get.lazyPut<DateController>(() => DateController());
    Get.lazyPut<SelectTroopController>(() => SelectTroopController());
  }
}