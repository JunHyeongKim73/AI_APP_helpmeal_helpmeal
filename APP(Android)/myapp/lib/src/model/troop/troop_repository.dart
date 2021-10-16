import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:myapp/src/model/troop/group.dart';
import 'troop.dart';

class TroopRepository {
  static List<Troop> troopList = [
    Troop(name: '육군', troops: [
      Troop(name: '수도방위사령부', troops: [
        Troop(name: '52사단', isLast: true),
        Troop(name: '56사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '특수전사령부', isLast: true),
      Troop(name: '지상작전사령부', troops: [
        Troop(name: '36사단', isLast: true),
        Troop(name: '55사단', isLast: true),
        Troop(name: '제1군수지원사령부', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '수도군단', troops: [
        Troop(name: '17사단', isLast: true),
        Troop(name: '51사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '1군단', troops: [
        Troop(name: '1사단', isLast: true),
        Troop(name: '9사단', isLast: true),
        Troop(name: '25사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '2군단', troops: [
        Troop(name: '7사단', isLast: true),
        Troop(name: '15사단', isLast: true),
        Troop(name: '27사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '3군단', troops: [
        Troop(name: '12사단', isLast: true),
        Troop(name: '21사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '5군단', troops: [
        Troop(name: '3사단', isLast: true),
        Troop(name: '6사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '6군단', troops: [
        Troop(name: '5사단', isLast: true),
        Troop(name: '28사단', isLast: true),
        Troop(name: '73사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '7군단', troops: [
        Troop(name: '수기사단', isLast: true),
        Troop(name: '2사단', isLast: true),
        Troop(name: '8사단', isLast: true),
        Troop(name: '11사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '8군단', troops: [
        Troop(name: '22사단', isLast: true),
        Troop(name: '23사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '제2작전사령부', troops: [
        Troop(name: '31사단', isLast: true),
        Troop(name: '32사단', isLast: true),
        Troop(name: '35사단', isLast: true),
        Troop(name: '37사단', isLast: true),
        Troop(name: '39사단', isLast: true),
        Troop(name: '50사단', isLast: true),
        Troop(name: '53사단', isLast: true),
        Troop(name: '제5군수지원사령부', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '교육사령부', isLast: true),
      Troop(name: '동원전력사령부', troops: [
        Troop(name: '60사단', isLast: true),
        Troop(name: '72사단', isLast: true),
        Troop(name: '66사단', isLast: true),
        Troop(name: '75사단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '직할부대', isLast: true),
    ]),
    Troop(name: '공군', troops: [
      Troop(name: '작전사령부', troops: [
        Troop(name: '방공유도탄사령부', isLast: true),
        Troop(name: '공중전투사령부', isLast: true),
        Troop(name: '공중기동정찰사령부', isLast: true),
        Troop(name: '방공관제사령부', isLast: true),
        Troop(
          name: '직할부대',
          isLast: true,
          group: ['오산기지'],
        ),
      ]),
      Troop(name: '군수사령부', isLast: true),
      Troop(name: '교육사령부', isLast: true),
      Troop(name: '직할부대', isLast: true),
    ]),
    Troop(name: '해군', troops: [
      Troop(name: '작전사령부', troops: [
        Troop(name: '1함대', isLast: true),
        Troop(name: '2함대', isLast: true),
        Troop(name: '3함대', isLast: true),
        Troop(name: '잠수함사령부', isLast: true),
        Troop(name: '제5성분전단', isLast: true),
        Troop(name: '제6항공전단', isLast: true),
        Troop(name: '제7기동전단', isLast: true),
        Troop(name: '직할부대', isLast: true),
      ]),
      Troop(name: '해병대사령부', isLast: true),
      Troop(name: '군수사령부', isLast: true),
      Troop(name: '교육사령부', isLast: true),
      Troop(name: '해군사관학교', isLast: true),
      Troop(name: '직할부대', isLast: true),
    ]),
  ];

  static Future<void> postTroop(Group group) async {
    final response =
        await http.post(Uri.parse('https://helpmeal.duckdns.org/troops/post'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(group.troopMap));
    print(response.statusCode);
    print(jsonDecode(response.body));
    if (response.statusCode == 201) {
      print('POST Completed!');
    } else {
      throw Exception('failed');
    }
  }

  static Future<List<Group>> getTroop(Group group) async {
    print(group.troopMap);
    Group plusGroup = Group.clone(group);

    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/troops/get'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(group.troopMap),
    );

    print(response.statusCode);

    final body = jsonDecode(response.body);
    print(body);

    if (response.statusCode == 200) {
      List<Group> groupList = [];
      for (var i = 0; i < body['troop'].length; i++) {
        groupList.add(Group.fromJson(body['troop'][i]));
      }
      groupList.add(plusGroup);
      return groupList;
    } else if (response.statusCode == 400) {
      return [plusGroup];
    } else {
      throw Exception('failed to load');
    }
  }
}
