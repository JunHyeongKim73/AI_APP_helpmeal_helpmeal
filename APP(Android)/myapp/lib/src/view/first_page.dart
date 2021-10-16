import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.local_restaurant,
              size: 200,
            ),
            Text.rich(TextSpan(text: '', children: <TextSpan>[
              TextSpan(
                  text: 'H',
                  style: TextStyle(
                    fontSize: 80.0,
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.bold,
                  )),
              const TextSpan(
                  text: 'elp',
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ))
            ])),
            const Text.rich(TextSpan(text: '', children: <TextSpan>[
              TextSpan(
                  text: 'M',
                  style: TextStyle(
                    fontSize: 80.0,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  )),
              TextSpan(
                  text: 'eal',
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ))
            ])),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child: Text('로그인', style: GoogleFonts.doHyeon(fontSize: 18, color: Colors.white)),
                    onPressed: () => Get.toNamed('/login'),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child: Text('로그인 없이 시작', style: GoogleFonts.doHyeon(fontSize: 18, color: Colors.white)),
                    onPressed: () => Get.toNamed('/troopSelect'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
