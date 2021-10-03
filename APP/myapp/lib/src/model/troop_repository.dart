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
          group: ['작전정보통신단', '작전근무지원단'],
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
}
