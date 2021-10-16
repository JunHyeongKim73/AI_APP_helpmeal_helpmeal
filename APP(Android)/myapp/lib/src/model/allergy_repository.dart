import 'allergy.dart';

const Map<String, String> nameList = {
  'egg': '난류',
  'milk': '우유',
  'buckwheat': '메밀',
  'peanut': '땅콩',
  'soybean': '대두',
  'wheat': '밀',
  //'pinenut': '잣',
  //'walnut': '호두',
  'crab': '게',
  'shrimp': '새우',
  //'squid': '오징어',
  'fish': '고등어',
  //'clam': '조개',
  'peach': '복숭아',
  'tomato': '토마토',
  //'chicken': '닭고기',
  'pork': '돼지고기',
  //'beef': '소고기',
  'wine': '아황산염',
};

class AllergyRepository {
  static List<Allergy> allergyList = [];

  static void init() {
    nameList.forEach((key, value) {
      allergyList.add(
        Allergy(
          assetPath: constructPath(key),
          engName: key,
          korName: value,
          isSelected: false,
        ),
      );
    });
  }
}



String constructPath(String assetPath) {
  return 'assets/allergy_icon/$assetPath.png';
}