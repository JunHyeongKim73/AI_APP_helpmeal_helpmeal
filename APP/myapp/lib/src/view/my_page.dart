import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/model/my_page_icon.dart';

class MyPage extends StatelessWidget {
  final bool isLogined = true;
  final bool isAdminstrator = true;
  final String kind = 'army';

  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFCF1B),
                Color(0xFFFF881B),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [BoxShadow(blurRadius: 20)],
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(MediaQuery.of(context).size.width, 120),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 160,
                    width: 240,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {},
                            icon: _imageSelection(),
                            iconSize: 48,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isLogined ? '김준형' : '',
                                style: GoogleFonts.doHyeon(
                                    fontSize: 20, color: Colors.white),
                              ),
                              isAdminstrator ? const SizedBox(width: 2) : const SizedBox(),
                              isAdminstrator ? _masterIcon() : Container(),
                            ],
                          ),
                        ),
                        Text(isLogined ? '공군 오산기지' : '',
                            style: GoogleFonts.doHyeon(
                                fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Column(
                      children: [
                        const SizedBox(height: 200),
                        isLogined ? _loginButtonView() : _notLoginButtonView(),
                      ],
                    ),
                    right: 0,
                    left: 0,
                    bottom: -20,
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
        _myPageIconsView(),
      ]),
    );
  }

  Widget _imageSelection() {
    if (isLogined) {
      return Image.asset('assets/user_icon/$kind.png');
    }
    return const Icon(MdiIcons.account, color: Colors.grey, size: 36);
  }

  Widget _notLoginButtonView() {
    return _myPageButton('로그인');
  }

  Widget _loginButtonView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _myPageButton('로그아웃'),
        const SizedBox(width: 20),
        _myPageButton('정보 변경'),
      ],
    );
  }

  Widget _myPageButton(String text) {
    return SizedBox(
      height: 40,
      width: 90,
      child: ElevatedButton(
        onPressed: () {},
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          primary: Colors.white,
          elevation: 3,
        ),
      ),
    );
  }

  Widget _myPageIconsView() {
    List<MyPageIcon> myPageIconList = isAdminstrator
        ? MyPageIcon.adminMyPageIconList
        : MyPageIcon.userMyPageIconList;

    if (!isLogined) {
      return Container();
    }
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(6.0),
        child: GridView.builder(
          itemCount: myPageIconList.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 1.5,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            maxCrossAxisExtent: 200,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () =>
                        Get.toNamed(myPageIconList[index].pageName),
                    icon: Icon(myPageIconList[index].iconData,
                        color: CustomColor.themeColor),
                    iconSize: 42,
                  ),
                  Text(myPageIconList[index].text,
                      style: GoogleFonts.doHyeon(fontSize: 16)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _masterIcon() {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Colors.white,
      child: Text('M',
          style: GoogleFonts.anton(fontSize: 12, color: Colors.green)),
    );
  }
}
