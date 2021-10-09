class User {
  late String email;
  late String password;
  late String name;
  late String milNum;
  final String milName;
  final String troopName;
  final String groupName;
  final List<String> allergyList;
  late bool isAdmin;
  late bool isLogined;

  User({
    this.email = '',
    this.password = '',
    this.name = '',
    this.milNum = '',
    this.isAdmin = false,
    required this.milName,
    required this.troopName,
    required this.groupName,
    required this.allergyList,
  }){
    isLogined = (email == '' ? false : true);
  }

  
}
