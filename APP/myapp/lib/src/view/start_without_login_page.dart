import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/view/notice_check_page.dart';
import 'package:myapp/src/view/suggestion_check_page.dart';
import 'package:myapp/src/view/suggestion_complain_page.dart';

class StartWithNoLoginPage extends StatefulWidget {
  StartWithNoLoginPage({Key? key}) : super(key: key);

  @override
  State<StartWithNoLoginPage> createState() => _StartWithNoLoginPageState();
}

class _StartWithNoLoginPageState extends State<StartWithNoLoginPage> {
  final bool isFirstPhase = true;
  final bool isSecondPhase = false;
  final bool isThirdPhase = false;

  final String selectedString = 'army';

  final Map<String, bool> isSelected = {
    'army': false,
    'airfoce': false,
    'navy': false
  };

  final List<String> armyList = ['육군', '공군', '해군'];
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Text('본인이 속한 군을 골라주세요', style: GoogleFonts.doHyeon(fontSize: 28)),
          const SizedBox(height: 10),
          progressBar(),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: PageView(
                controller: pageController,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _selectArmyIcon('army', '육군'),
                              const SizedBox(width: 30),
                              _selectArmyIcon('airforce', '공군'),
                              const SizedBox(width: 30),
                              _selectArmyIcon('navy', '해군'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(MdiIcons.chevronRight, color: Colors.black,),
                              iconSize: 48,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox.expand(
                    child: Container(
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          'Page index : 1',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.expand(
                    child: Container(
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          'Page index : 2',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.expand(
                    child: Container(
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          'Page index : 3',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _selectArmyIcon(String kind, String text) {
    return Column(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundColor:
              isSelected[kind] == true ? CustomColor.themeColor : Colors.grey,
          child: CircleAvatar(
            radius: 42,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isSelected[kind] = (isSelected[kind] == true ? false : true);
                });
                // pageController.nextPage(
                //   duration: Duration(milliseconds: 350),
                //   curve: Curves.easeIn,
                // );
              },
              icon: Image.asset('assets/user_icon/$kind.png'),
              iconSize: kind == 'airforce' ? 56 : 64,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Widget progressBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: CustomColor.themeColor,
          child: Text('1', style: TextStyle(color: Colors.white)),
        ),
        Container(
            height: 3,
            width: 40,
            color: isSecondPhase ? CustomColor.themeColor : Colors.white),
        CircleAvatar(
          radius: isSecondPhase ? 28 : 24,
          backgroundColor:
              isSecondPhase ? CustomColor.themeColor : Colors.white,
          child: Text('2',
              style: TextStyle(
                  color:
                      isSecondPhase ? Colors.white : CustomColor.themeColor)),
        ),
        Container(
            height: 3,
            width: 40,
            color: isThirdPhase ? CustomColor.themeColor : Colors.white),
        CircleAvatar(
          radius: isThirdPhase ? 28 : 24,
          backgroundColor: isThirdPhase ? CustomColor.themeColor : Colors.white,
          child: Text('3',
              style: TextStyle(
                  color: isThirdPhase ? Colors.white : CustomColor.themeColor)),
        ),
      ],
    );
  }
}
