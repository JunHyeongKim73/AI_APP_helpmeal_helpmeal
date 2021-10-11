class Food {
  String name;
  int order;
  List<dynamic>? allergyList = [];

  Food({this.name = '', this.order = -1, this.allergyList});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      order: json['order'],
      allergyList: json['allergy'],
    );
  }

  bool hasAllergy(List<dynamic> userAllergyList){
    for(var userAllergy in userAllergyList){
      if(allergyList!.contains(userAllergy)){
        return true;
      }
    }
    return false;
  }
}
