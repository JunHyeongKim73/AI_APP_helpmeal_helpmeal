import 'package:myapp/src/model/troop/group.dart';

class User {
  String? email;
  String? password;
  String? name;
  String? milNum;
  String? milName;
  List<dynamic>? allergyList = [];
  Group? groups;
  int? isAdmin;
  bool? isLogined;
  String? messege;

  User({
    this.email = '',
    this.password = '',
    this.name = '',
    this.milNum = '',
    this.isAdmin = 0,
    this.milName = '',
    this.allergyList,
    this.groups,
    this.messege
  }){
    isLogined = (name == '' ? false : true);
    milName = groups!.milName;
  }
}
