import 'package:flutter/material.dart';

class CustomColor {
  static const String appName = 'Help Meal';

  static const MaterialColor orangeColor = MaterialColor(
    0xffffe0b2, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffe6caa0), //10%
      100: Color(0xffccb38e), //20%
      200: Color(0xffb39d7d), //30%
      300: Color(0xff99866b), //40%
      400: Color(0xff807059), //50%
      500: Color(0xff665a47), //60%
      600: Color(0xff4c4335), //70%
      700: Color(0xff332d24), //80%
      800: Color(0xff191612), //90%
      900: Color(0xff000000), //100%
    },
  );
}
