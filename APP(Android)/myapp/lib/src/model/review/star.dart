class Star {
  String? name;
  int? order;
  double? stars;
  Map<String, dynamic>? mapData;

  Star({this.name, this.order, this.stars}) {
    mapData = {'name': name, 'order': order, 'stars': stars};
  }
}
