import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collection/collection.dart';

import 'package:myapp/src/model/allergy.dart';
import 'package:myapp/src/model/allergy_repository.dart';
import 'package:myapp/src/model/fonts.dart';

class AllergyPage extends StatelessWidget {
  const AllergyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: CustomFont(fontSize: 56).logo,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('알레르기가 있는 음식을 선택해주세요!',
                  style: GoogleFonts.cuteFont(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const AllergyView(),
          ],
        ),
      ),
    );
  }
}

class AllergyView extends StatefulWidget {
  const AllergyView({Key? key}) : super(key: key);

  @override
  State<AllergyView> createState() => _AllergyViewState();
}

class _AllergyViewState extends State<AllergyView> { 
  late List<Allergy> allergyList;
  late List<bool> selectedList;
  int selectedNum = 0;

  @override
  void initState() {
    AllergyRepository.init();
    allergyList = AllergyRepository.allergyList;
    selectedList = List.filled(allergyList.length, false);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {   
    return Flexible(
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: allergyList.length,
            itemBuilder: (BuildContext ctx, index) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: allergyList[index].isSelected
                        ? Colors.grey[350]
                        : Colors.white,
                    child: IconButton(
                      icon: Image.asset(allergyList[index].assetPath),
                      onPressed: () => setState(() {
                        allergyList[index].isSelected = !allergyList[index].isSelected;
                        selectedList[index] = !selectedList[index];
                        selectedNum = selectedList.where((element) => element == true).toList().length;
                      }),
                      iconSize: 36,
                    ),
                  ),
                  Text(allergyList[index].korName,
                      style: GoogleFonts.doHyeon(fontSize: 20)),
                ],
              );
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: 180,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    List<String> selectedAllergy = [];
                    selectedList.forEachIndexed((index, element) { 
                      if(element == true){
                        selectedAllergy.add(allergyList[index].engName);
                      }
                    });
                  },
                  child: Text(
                    selectedNum == 0 ? '알레르기가 없어요': '선택 완료',
                    style: GoogleFonts.doHyeon(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
