import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myapp/src/controller/sign_up_controller.dart';
import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/model/meal/menu_repository.dart';
import 'package:myapp/src/model/user/user.dart';
import 'package:myapp/src/model/user/user_repository.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 15.0,
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: CustomColor.themeColor,
                        ),
                        child: Center(
                          child: Text(
                            '회원가입',
                            style: GoogleFonts.doHyeon(
                                fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (text) {
                                      controller.setEmail(text);
                                    },
                                    decoration: InputDecoration(
                                      hintText: "아이디(example@email.com)",
                                      hintStyle: const TextStyle(
                                        color: Color(0xFFBDC2CB),
                                        fontSize: 15.0,
                                      ),
                                      errorText: controller.isEmail
                                          ? '아이디를 입력해주세요!'
                                          : null,
                                    ),
                                  ),
                                ),
                                _checkOverlap(controller.email),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            TextField(
                              onChanged: (text) {
                                controller.setPassword(text);
                              },
                              decoration: InputDecoration(
                                hintText: "비밀번호",
                                hintStyle: const TextStyle(
                                  color: Color(0xFFBDC2CB),
                                  fontSize: 15.0,
                                ),
                                errorText: controller.isPassword
                                    ? '비밀번호를 입력해주세요!'
                                    : null,
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 20.0),
                            TextField(
                              onChanged: (text) {
                                controller.setname(text);
                              },
                              decoration: InputDecoration(
                                hintText: "이름",
                                hintStyle: const TextStyle(
                                  color: Color(0xFFBDC2CB),
                                  fontSize: 15.0,
                                ),
                                errorText:
                                    controller.isName ? '이름을 입력해주세요!' : null,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextField(
                              onChanged: (text) {
                                controller.setMilNum(text);
                              },
                              decoration: InputDecoration(
                                hintText: "군번",
                                hintStyle: const TextStyle(
                                  color: Color(0xFFBDC2CB),
                                  fontSize: 15.0,
                                ),
                                errorText:
                                    controller.isMilNum ? '군번을 입력해주세요!' : null,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            ListTile(
                              title: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => controller.setAdmin(0),
                                      child: Text("병사",
                                          style: TextStyle(
                                              color: controller.isAdmin == 1
                                                  ? CustomColor.themeColor
                                                  : Colors.white)),
                                      style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        primary: controller.isAdmin == 1
                                            ? Colors.white
                                            : CustomColor.themeColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => controller.setAdmin(1),
                                      child: Text("식당 관리자",
                                          style: TextStyle(
                                              color: controller.isAdmin == 1
                                                  ? Colors.white
                                                  : CustomColor.themeColor)),
                                      style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        primary: controller.isAdmin == 1
                                            ? CustomColor.themeColor
                                            : Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 80,
                child: ElevatedButton(
                  onPressed: () {
                    controller.checkComplete();
                    if (controller.isNextPage) {
                      Get.toNamed('/troopSelect', arguments: controller);
                    }
                  },
                  child: Text(
                    '완료',
                    style:
                        GoogleFonts.doHyeon(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  FutureBuilder<Object?> _checkOverlap(String email) {
    Future<bool> isOverlapped = UserRepository.checkUser(email);
    return FutureBuilder(
      future: isOverlapped,
      builder: (context, snapshot) {
        return OutlinedButton(
          onPressed: () {
            if (snapshot.hasData) {
              String text = '중복된 이메일입니다.';
              if (snapshot.data == false) {
                text = '사용할 수 있는 이메일입니다.';
              }
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(content: Text(text), actions: <Widget>[
                    TextButton(onPressed: () => Get.back(), child: Text('확인'))
                  ]);
                },
              );
            }
          },
          child: const Text('중복확인'),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(width: 1, color: CustomColor.themeColor),
          ),
        );
      },
    );
  }
}
