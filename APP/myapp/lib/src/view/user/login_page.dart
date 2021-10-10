import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/app.dart';

import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/model/fonts.dart';
import 'package:myapp/src/model/user/user_repository.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: CustomFont(fontSize: 56).logo,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 15.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            email = text;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: "example@email.com",
                          hintStyle: TextStyle(
                            color: Color(0xFFBDC2CB),
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            password = text;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: "비밀번호",
                          hintStyle: TextStyle(
                            color: Color(0xFFBDC2CB),
                            fontSize: 15.0,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 40.0,
              width: 240,
              child: ElevatedButton(
                onPressed: () {
                  print(email);
                  print(password);
                  UserRepository.getUser(email!, password!);
                },
                child: const Center(
                  child: Text(
                    "로그인",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  primary: CustomColor.themeColor,
                  shadowColor: Colors.white,
                  elevation: 3,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40.0,
              width: 240,
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/signUp'),
                child: const Center(
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: CustomColor.themeColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  primary: Colors.white,
                  shadowColor: CustomColor.themeColor,
                  elevation: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
