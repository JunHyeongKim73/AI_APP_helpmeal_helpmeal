import 'package:flutter/material.dart';

import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/model/fonts.dart';
import 'package:sign_button/sign_button.dart';

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
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
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
          Container(
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
          Container(
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
          // Padding(
          //   padding: const EdgeInsets.only(top: 10, bottom: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(height: 1, width: 150, color: Colors.grey),
          //       Text(' 또는 '),
          //       Container(height: 1, width: 150, color: Colors.grey),
          //     ],
          //   ),
          // ),
          // SignInButton(
          //   buttonType: ButtonType.facebook,
          //   onPressed: () {},
          //   btnText: 'Login With Facebook',
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // ),
          // const SizedBox(height: 8),
          // SignInButton(
          //   buttonType: ButtonType.google,
          //   onPressed: () {},
          //   btnText: 'Login With Google',
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // ),
          // const SizedBox(height: 8),
          // const KakaoButton(),
        ],
      ),
    ));
  }
}

// class KakaoButton extends StatelessWidget {
//   const KakaoButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       color: Color(0xFFFEE500),
//       disabledColor: Theme.of(context).disabledColor.withOpacity(0.12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       onPressed: () {},
//       elevation: 5.0,
//       child: Container(
//         width: 200,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: EdgeInsets.all(5.0),
//               child: Image.asset(
//                 '/workspaces/AI_APP_helpmeal_helpmeal/APP/myapp/assets/kakao.png',
//                 width: 24,
//                 height: 24,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(5.0),
//               child: Text(
//                 'Login With Kakao',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
