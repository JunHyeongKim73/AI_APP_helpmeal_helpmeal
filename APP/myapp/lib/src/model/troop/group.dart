class Group {
  Map<String, dynamic> troopMap = {
    '4' : '',
    '3' : '',
    '2' : '',
    '1' : '',
  };
  List<String>? lists;

  Group({this.lists}) {
    if (lists!.length == 3) {
      troopMap['4'] = lists![0];
      troopMap['3'] = lists![1];
      troopMap['2'] = lists![2];
    } else {
      troopMap['4'] = lists![0];
      troopMap['3'] = lists![1];
      troopMap['2'] = lists![2];
      troopMap['1'] = lists![3];
    }
  }
}
