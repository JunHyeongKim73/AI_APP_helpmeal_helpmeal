class Food {
  String? name = '';
  int? order = -1;
  List<dynamic>? allergy = [];

  Food({this.name, this.order, this.allergy});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      order: json['order'],
      allergy: json['allergy'],
    );
  }
}
