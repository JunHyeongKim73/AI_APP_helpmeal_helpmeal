import 'package:myapp/src/model/troop/group.dart';

class User {
  String? email;
  String? password;
  String? name;
  String? milNum;
  String? milName;
  String? troopName;
  String? groupName;
  int? troopId;
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
    this.troopName = '',
    this.groupName = '',
    this.troopId = 0,
    this.allergyList,
    this.groups,
    this.messege
  }){
    isLogined = (name == '' ? false : true);
  }
}
