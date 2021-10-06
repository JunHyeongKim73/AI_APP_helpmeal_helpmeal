import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:myapp/src/controller/select_troop_controller.dart';
import 'package:myapp/src/controller/sign_up_controller.dart';
import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/model/troop.dart';

class TroopSelectPage extends StatefulWidget {
  const TroopSelectPage({Key? key}) : super(key: key);

  @override
  State<TroopSelectPage> createState() => _TroopSelectPage();
}

class _TroopSelectPage extends State<TroopSelectPage> {
  static const engNameList = ['army', 'airforce', 'navy'];
  static const korNameList = ['육군', '공군', '해군'];
  late List<Troop> troopList;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectTroopController>(builder: (controller) {
      troopList = controller.troopList;
      return Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 50),
            _textBuilder(controller),
            const SizedBox(height: 10),
            progressBar(controller),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: PageView(
                  controller: controller.pageController,
                  children: [
                    _firstPage(controller),
                    _secondPage(controller),
                    _secondPlusPage(controller),
                    _thirdPage(controller),
                  ],
                ),
              ),
            ),
            _buttonBuilder(controller),
            const SizedBox(height: 60),
          ],
        ),
      );
    });
  }

  Widget _buttonBuilder(SelectTroopController controller) {
    SignUpController signUpController = Get.arguments;
    signUpController = SignUpController();
    
    switch (controller.pageIndex) {
      case 0:
        return CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: controller.nextPage,
            icon: Icon(
              MdiIcons.chevronRight,
              color: controller.selectedIconIndex == -1
                  ? Colors.black
                  : CustomColor.themeColor,
            ),
            iconSize: 48,
          ),
        );
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: controller.previousPage,
                icon: const Icon(
                  MdiIcons.chevronLeft,
                  color: CustomColor.themeColor,
                ),
                iconSize: 48,
              ),
            ),
            const SizedBox(width: 15),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: controller.nextPage,
                icon: Icon(
                  MdiIcons.chevronRight,
                  color: controller.isThirdPageOn
                      ? CustomColor.themeColor
                      : Colors.black,
                ),
                iconSize: 48,
              ),
            ),
          ],
        );
      default:
        if (controller.selectedGroupIndex == -1) {
          return CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: controller.previousPage,
              icon: const Icon(
                MdiIcons.chevronLeft,
                color: CustomColor.themeColor,
              ),
              iconSize: 48,
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: () {
              controller.selectTroopCompleted();
              signUpController.setTroops(controller.milName, controller.troopName, controller.groupName);
              Get.toNamed('/allergy', arguments: signUpController);
            },
            child: const Text('완료',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              primary: Colors.white,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
    }
  }

  Widget _firstPage(SelectTroopController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectArmyIcon(controller, 0),
            const SizedBox(width: 30),
            _selectArmyIcon(controller, 1),
            const SizedBox(width: 30),
            _selectArmyIcon(controller, 2),
          ],
        ),
      ],
    );
  }

  Widget _secondPage(SelectTroopController controller) {
    if (controller.selectedIconIndex == -1) return Container();

    List<Troop>? troops = troopList[controller.selectedIconIndex].troops;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: troopList[controller.selectedIconIndex].troops!.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 1.5,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        maxCrossAxisExtent: 200,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ElevatedButton(
          onPressed: troops![index].isLast
              ? () => controller.changeButton(index)
              : () => controller.changeSelectedTroopIndex(index),
          child: Text(
            troops[index].name,
            style: GoogleFonts.doHyeon(fontSize: 24),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              side: BorderSide(
                width: 2,
                color: controller.selectedTroopIndex == index
                    ? CustomColor.themeColor
                    : Colors.grey,
              ),
              elevation: 5),
        );
      },
    );
  }

  Widget _secondPlusPage(SelectTroopController controller) {
    if (!controller.isPlusContainerOn) return Container();

    List<Troop>? troops = troopList[controller.selectedIconIndex].troops;
    List<Troop>? detailTroops = troops![controller.selectedTroopIndex].troops;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: detailTroops!.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 1.5,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        maxCrossAxisExtent: 180,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ElevatedButton(
          onPressed: () => controller.changeButton(index),
          child: Text(
            detailTroops[index].name,
            style: GoogleFonts.doHyeon(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              side: BorderSide(
                width: 2,
                color: controller.selectedDetailTroopIndex == index
                    ? CustomColor.themeColor
                    : Colors.grey,
              ),
              elevation: 5),
        );
      },
    );
  }

  Widget _thirdPage(SelectTroopController controller) {
    if (controller.pageIndex != 2) return Container();

    List<Troop>? troops = troopList[controller.selectedIconIndex].troops;
    List<String>? groups = troops![controller.selectedTroopIndex].groups;

    if (controller.selectedDetailTroopIndex != -1) {
      List<Troop>? detailTroops = troops[controller.selectedTroopIndex].troops;
      groups = detailTroops![controller.selectedDetailTroopIndex].groups;
    }

    return GridView.builder(
      shrinkWrap: true,
      itemCount: groups!.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 1.5,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        maxCrossAxisExtent: 150,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ElevatedButton(
          onPressed: index == groups!.length - 1
              ? () => _displayTroopInputDialog(context, controller)
              : () => controller.changeButton(index),
          child: Text(groups[index], style: GoogleFonts.doHyeon(fontSize: 20)),
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              side: BorderSide(
                width: 2,
                color: controller.selectedGroupIndex == index
                    ? CustomColor.themeColor
                    : Colors.grey,
              ),
              elevation: 5),
        );
      },
    );
  }

  Future<dynamic> _displayTroopInputDialog(
      BuildContext context, SelectTroopController controller) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('그룹을 입력하세요', style: GoogleFonts.doHyeon(fontSize: 24)),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: "오산기지",
              hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              child: Text('취소', style: GoogleFonts.doHyeon(fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                controller.addGroup(textController.text);
                Get.back();
              },
              child: Text('확인', style: GoogleFonts.doHyeon(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  Text _textBuilder(SelectTroopController controller) {
    String text = '';
    switch (controller.pageIndex) {
      case 0:
        text = '본인이 속한 군을 골라주세요';
        break;

      case 1:
        text = '본인이 속한 편대를 골라주세요';
        break;

      case 2:
        text = '본인이 속한 그룹을 골라주세요';
        break;
    }

    return Text(text, style: GoogleFonts.doHyeon(fontSize: 28));
  }

  Widget _selectArmyIcon(SelectTroopController controller, int idx) {
    return Column(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundColor: controller.selectedIconIndex == idx
              ? CustomColor.themeColor
              : Colors.grey,
          child: CircleAvatar(
            radius: 42,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () => controller.changeSelectedIconIndex(idx),
              icon: Image.asset('assets/user_icon/${engNameList[idx]}.png'),
              iconSize: engNameList[idx] == 'airforce' ? 56 : 64,
            ),
          ),
        ),
        Text(korNameList[idx],
            style: const TextStyle(fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget progressBar(SelectTroopController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: CustomColor.themeColor,
          child: Text('1', style: TextStyle(color: Colors.white)),
        ),
        Container(
            height: 3,
            width: 40,
            color: controller.pageIndex == 1 || controller.pageIndex == 2
                ? CustomColor.themeColor
                : Colors.white),
        CircleAvatar(
          radius:
              controller.pageIndex == 1 || controller.pageIndex == 2 ? 28 : 24,
          backgroundColor:
              controller.pageIndex == 1 || controller.pageIndex == 2
                  ? CustomColor.themeColor
                  : Colors.white,
          child: Text('2',
              style: TextStyle(
                  color: controller.pageIndex == 1 || controller.pageIndex == 2
                      ? Colors.white
                      : CustomColor.themeColor)),
        ),
        Container(
            height: 3,
            width: 40,
            color: controller.pageIndex == 2
                ? CustomColor.themeColor
                : Colors.white),
        CircleAvatar(
          radius: controller.pageIndex == 2 ? 28 : 24,
          backgroundColor:
              controller.pageIndex == 2 ? CustomColor.themeColor : Colors.white,
          child: Text('3',
              style: TextStyle(
                  color: controller.pageIndex == 2
                      ? Colors.white
                      : CustomColor.themeColor)),
        ),
      ],
    );
  }
}
