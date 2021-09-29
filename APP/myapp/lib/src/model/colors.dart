import 'package:flutter/material.dart';

class CustomColor {
  static const String appName = 'Help Meal';

  static const Color themeColor = Color(0xffffb74d);

  static const MaterialColor orangeColor = MaterialColor(
    0xffffb74d, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffe6a545), //10%
      100: Color(0xffcc923e), //20%
      200: Color(0xffb38036), //30%
      300: Color(0xff996e2e), //40%
      400: Color(0xff805c27), //50%
      500: Color(0xff66491f), //60%
      600: Color(0xff4c3717), //70%
      700: Color(0xff33250f), //80%
      800: Color(0xff191208), //90%
      900: Color(0xff000000), //100%
    },
  );
}
