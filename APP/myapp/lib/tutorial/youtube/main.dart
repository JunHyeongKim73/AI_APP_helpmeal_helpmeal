import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:myapp/tutorial/youtube/src/app.dart';

import 'src/binding/init_binding.dart';

/*
cd APP/myapp
flutter run -d web-server --web-hostname=0.0.0.0
*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Youtube Clone App',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      initialBinding: InitBinding(),
      getPages: [ 
        GetPage(name: '/', page: () => App())
      ],
    );
  }
}
