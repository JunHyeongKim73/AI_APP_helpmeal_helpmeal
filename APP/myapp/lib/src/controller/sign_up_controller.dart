import 'package:get/get.dart';
import 'package:myapp/src/model/troop/group.dart';

class SignUpController extends GetxController {
  String email = '';
  bool isEmail = false;
  bool isOverlapCheck = false;

  String password = '';
  bool isPassword = false;

  String name = '';
  bool isName = false;

  String milNum = '';
  bool isMilNum = false;

  int isAdmin = 0;
  bool isNextPage = false;

  List<String> allergy = [];
  Group? groups;

  void setEmail(String text) {
    email = text;
    update();
  }

  void setCheck(bool flag){
    isOverlapCheck = flag;
    update();
  }

  void setPassword(String text) {
    password = text;
    update();
  }

  void setname(String text) {
    name = text;
    update();
  }

  void setMilNum(String text) {
    milNum = text;
    update();
  }

  void checkComplete() {
    isEmail = (email == '' ? true : false);
    isPassword = (password == '' ? true : false);
    isName = (name == '' ? true : false);
    isMilNum = (milNum == '' ? true : false);

    if (!(isEmail || isPassword || isName || isMilNum) && isOverlapCheck) {
      isNextPage = true;
    } else {
      isNextPage = false;
    }

    update();
  }

  void setAdmin(int num) {
    isAdmin = num;
    update();
  }

  void setTroops(Group _groups) {
    groups = _groups;
    update();
  }

  void setAllergy(List<String> _allergy){
    allergy = _allergy;
    update();
  }
}
