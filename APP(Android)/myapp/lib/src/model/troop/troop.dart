class Troop {
  String name;
  List<Troop>? troops = [];
  List<String>? groups = [];
  List<String>? group = [];
  bool isLast;

  Troop({
    this.name = '',
    this.troops,
    this.group,
    this.isLast = false,
  }){ 
    group ??= [];
    groups = group! + ['+'];
  }
}
