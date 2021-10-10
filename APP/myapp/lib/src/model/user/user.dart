class User {
  late String email;
  late String password;
  late String name;
  late String milNum;
  String? milName;
  String? troopName;
  String? groupName;
  List<String>? allergyList;
  late int isAdmin;
  late bool isLogined;

  User({
    this.email = '',
    this.password = '',
    this.name = '',
    this.milNum = '',
    this.isAdmin = 0,
    this.milName,
    this.troopName,
    this.groupName,
    this.allergyList,
  }){
    isLogined = (email == '' ? false : true);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      
    );
  }
}
