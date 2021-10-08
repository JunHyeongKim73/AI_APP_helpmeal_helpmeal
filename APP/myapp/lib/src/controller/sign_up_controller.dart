import 'package:get/get.dart';

class SignUpController extends GetxController {
  String email = '';
  bool isEmail = false;

  String password = '';
  bool isPassword = false;

  String name = '';
  bool isName = false;

  String milNum = '';
  bool isMilNum = false;

  bool isAdmin = false;
  bool isNextPage = false;

  List<String> allergy = [];
  String milName = '';
  String troopName = '';
  String groupName = '';

  void setEmail(String text) {
    email = text;
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

    if (!(isEmail || isPassword || isName || isMilNum)) {
      isNextPage = true;
    } else {
      isNextPage = false;
    }

    update();
  }

  void setAdmin(bool flag) {
    isAdmin = flag;
    update();
  }

  void setTroops(String _milName, String _troopName, String _groupName) {
    milName = _milName;
    troopName = _troopName;
    groupName = _groupName;
    update();
  }

  void setAllergy(List<String> _allergy){
    allergy = _allergy;
    update();
  }
}
