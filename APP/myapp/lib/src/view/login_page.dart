import 'package:flutter/material.dart';

import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/model/fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  children: const <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        hintText: "example@email.com",
                        hintStyle: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
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
              onPressed: () {},
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
              onPressed: () {},
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
    ));
  }
}
