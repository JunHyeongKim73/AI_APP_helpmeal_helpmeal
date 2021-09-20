import 'package:get/get.dart';
import '../controller/app_controller.dart';

class InitBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(AppController());
  }
}