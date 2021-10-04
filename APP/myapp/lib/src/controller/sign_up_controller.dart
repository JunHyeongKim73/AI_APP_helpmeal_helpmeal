import 'package:get/get.dart';

class SignUpController extends GetxController {
  var email = '';
  bool isEmail = false;

  var password = '';
  bool isPassword = false;

  var name = '';
  bool isName = false;

  var milNum = '';
  bool isMilNum = false;

  bool isAdmin = false;
  bool isNextPage = false;

  var allergy = [];
  var troopName = '';
  var groupName = '';

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

  void setTroops(String _troopName, String _groupName) {
    troopName = _troopName;
    groupName = _groupName;
    update();
  }

  void setAllergy(List<String> _allergy){
    allergy = _allergy;
    update();
  }
}
