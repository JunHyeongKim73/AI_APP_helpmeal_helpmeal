import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/model/colors.dart';

import 'src/app.dart';
import 'src/binding/init_binding.dart';

void main() => runApp(const MyAPP());

class MyAPP extends StatelessWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: CustomColor.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: CustomColor.orangeColor,
        ),
        scaffoldBackgroundColor: Colors.grey[100]
      ),
      initialRoute: '/',
      initialBinding: InitBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const App(),
        ),
      ],
    );
  }
}
